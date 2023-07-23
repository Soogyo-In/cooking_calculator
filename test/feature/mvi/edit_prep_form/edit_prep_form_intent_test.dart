import 'package:cooking_calulator/feature/mvi/edit_prep_form/edit_prep_form_mvi.dart';
import 'package:cooking_calulator/model/enum/amount_unit.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:data/model/schema/schema.dart' as schema;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/mockito.dart';

import 'error_recipe_local_datasource.dart';

class StateListener extends Mock {
  void call(EditPrepFormState? previous, EditPrepFormState next);
}

class EffectListener extends Mock {
  void call(EditPrepFormEffect? previous, EditPrepFormEffect? next);
}

void main() {
  const databasePath = './';
  late ProviderContainer container;
  late StateListener stateListener;
  late EffectListener effectListener;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    final isar = await Isar.open(
      [schema.IngredientSchema],
      directory: databasePath,
    );
    await isar.writeTxn(
      () => isar.ingredients.putAll([
        const schema.Ingredient(id: 1, name: 'thyme'),
        const schema.Ingredient(id: 2, name: 'tomato'),
        const schema.Ingredient(id: 3, name: 'tortillas'),
      ]),
    );
    await isar.close();

    final datasource = RecipeLocalDatasource(databasePath);

    container = ProviderContainer(
      overrides: [
        recipeLocalDatasourceProvider.overrideWith(
          (ref) => datasource,
        ),
      ],
    );
    stateListener = StateListener();
    effectListener = EffectListener();
  });

  tearDown(() async {
    final isar = await Isar.open(
      [schema.IngredientSchema],
      directory: databasePath,
    );
    await isar.writeTxn(() => isar.clear());
    await isar.close();
    container.dispose();
  });

  group(
    '초기화 시',
    () {
      test(
        'Prep 이 주어지지 않으면 기본 값으로 초기화한다.',
        () {
          container.listen(
            editPrepFormIntentProvider(null),
            stateListener.call,
            fireImmediately: true,
          );

          verify(
            stateListener(
              null,
              const EditPrepFormState(),
            ),
          ).called(1);
        },
      );

      test(
        'Prep 이 주어지면 Prep 으로 기본 값을 초기화한다.',
        () {
          const ingredient = Ingredient(
            name: 'tomato',
            description: 'San Marzano tomato',
          );
          final amount = Gram(100.0);

          container.listen(
            editPrepFormIntentProvider(
              Prep(
                ingredient: ingredient,
                amount: amount,
              ),
            ),
            stateListener.call,
            fireImmediately: true,
          );

          verify(
            stateListener(
              null,
              EditPrepFormState(
                amountUnit: MassUnit.gram,
                amountValue: amount.value,
                ingredient: ingredient,
              ),
            ),
          ).called(1);
        },
      );
    },
  );

  group(
    '재료검색 시',
    () {
      test(
        '로딩 상태로 전이 후 데이터베이스에 같은 이름의 재료가 있다면 선택한다.',
        () async {
          final provider = editPrepFormIntentProvider(null);

          container.listen(
            provider,
            stateListener.call,
          );
          await container
              .read(provider.notifier)
              .submitIngredientName('tomato');

          verifyInOrder(
            [
              stateListener(
                const EditPrepFormState(),
                const EditPrepFormState(isLoading: true),
              ),
              stateListener(
                const EditPrepFormState(isLoading: true),
                const EditPrepFormState(
                  isLoading: false,
                  ingredient: StoredIngredient(
                    id: 2,
                    name: 'tomato',
                  ),
                ),
              ),
            ],
          );
        },
      );

      test(
        '로딩 상태로 전이 후 데이터베이스에 같은 이름의 재료가 없다면 검색한 이름으로 새로운 재료를 만들어 선택한다.',
        () async {
          final provider = editPrepFormIntentProvider(null);

          container.listen(
            provider,
            stateListener.call,
          );
          await container
              .read(provider.notifier)
              .submitIngredientName('tarragon');

          verifyInOrder(
            [
              stateListener(
                const EditPrepFormState(),
                const EditPrepFormState(isLoading: true),
              ),
              stateListener(
                const EditPrepFormState(isLoading: true),
                const EditPrepFormState(
                  isLoading: false,
                  ingredient: Ingredient(name: 'tarragon'),
                ),
              ),
            ],
          );
        },
      );

      test(
        '로딩 상태로 전이 후 데이터베이스 검색 중 오류가 생긴다면 SnackBar 를 노출한다.',
        () async {
          container = ProviderContainer(
            overrides: [
              recipeLocalDatasourceProvider.overrideWith(
                (ref) => ErrorRecipeLocalDatasource(databasePath),
              ),
            ],
          );

          final intentProvider = editPrepFormIntentProvider(null);
          final effectProvider = editPrepFormEffectProvider;

          container
            ..listen<EditPrepFormState>(
              intentProvider,
              stateListener.call,
            )
            ..listen<EditPrepFormEffect?>(
              effectProvider,
              effectListener.call,
            );

          await container
              .read(intentProvider.notifier)
              .submitIngredientName('tomato');

          verifyInOrder(
            [
              stateListener(
                const EditPrepFormState(),
                const EditPrepFormState(isLoading: true),
              ),
              stateListener(
                const EditPrepFormState(isLoading: true),
                const EditPrepFormState(isLoading: false),
              ),
              effectListener(
                null,
                EditPrepFormEffect.showErrorSnackBar(Exception().toString()),
              ),
            ],
          );
        },
      );
    },
  );

  test(
    '추천 재료 목록에서 재료를 선택한다.',
    () {
      final provider = editPrepFormIntentProvider(null);

      container.listen(
        provider,
        stateListener.call,
      );
      container
          .read(provider.notifier)
          .selectIngredient(const StoredIngredient(id: 2, name: 'tomato'));

      verify(
        stateListener(
          const EditPrepFormState(),
          const EditPrepFormState(
            ingredient: StoredIngredient(id: 2, name: 'tomato'),
          ),
        ),
      );
    },
  );

  test(
    '계량 단위를 변경한다.',
    () {
      final provider = editPrepFormIntentProvider(null);

      container.listen(
        provider,
        stateListener.call,
      );
      container.read(provider.notifier).changeAmountUnit(MassUnit.gram);

      verify(
        stateListener(
          const EditPrepFormState(),
          const EditPrepFormState(amountUnit: MassUnit.gram),
        ),
      );
    },
  );

  group(
    '계량값 변경 시',
    () {
      test(
        '숫자라면 변경한다.',
        () {
          final provider = editPrepFormIntentProvider(null);

          container.listen(
            provider,
            stateListener.call,
          );
          container.read(provider.notifier).changeAmountValue('2.0');

          verify(
            stateListener(
              const EditPrepFormState(),
              const EditPrepFormState(amountValue: 2.0),
            ),
          );
        },
      );

      test(
        '빈 문자열이라면 0.0 으로 변경한다.',
        () {
          final provider = editPrepFormIntentProvider(null);

          container.listen(
            provider,
            stateListener.call,
          );
          container.read(provider.notifier).changeAmountValue('');

          verify(
            stateListener(
              const EditPrepFormState(),
              const EditPrepFormState(amountValue: 0.0),
            ),
          );
        },
      );

      test(
        '숫자가 아니라면 SnackBar 를 노출한다.',
        () {
          final intentProvider = editPrepFormIntentProvider(null);
          final effectProvider = editPrepFormEffectProvider;

          container.listen<EditPrepFormEffect?>(
            effectProvider,
            effectListener.call,
          );
          container.read(intentProvider.notifier).changeAmountValue('a#1.1');

          verify(
            effectListener(
              null,
              const EditPrepFormEffect.showErrorSnackBar(
                'FormatException: Invalid double\na#1.1',
              ),
            ),
          );
        },
      );
    },
  );

  test(
    '주어진 키워드에 해당하는 추천 재료들을 제공한다.',
    () async {
      final provider = editPrepFormIntentProvider(null);

      container.listen(
        provider,
        stateListener.call,
      );
      container.read(provider.notifier).updateIngredientSearchSuggestions('t');
      await Future.delayed(const Duration(milliseconds: 100));
      container.read(provider.notifier).updateIngredientSearchSuggestions('to');
      await Future.delayed(const Duration(milliseconds: 100));
      container
          .read(provider.notifier)
          .updateIngredientSearchSuggestions('tom');
      await Future.delayed(const Duration(milliseconds: 100));

      verifyInOrder([
        stateListener(
          const EditPrepFormState(),
          const EditPrepFormState(
            ingredientSearchSuggestions: [
              StoredIngredient(id: 1, name: 'thyme'),
              StoredIngredient(id: 2, name: 'tomato'),
              StoredIngredient(id: 3, name: 'tortillas'),
            ],
          ),
        ),
        stateListener(
          const EditPrepFormState(
            ingredientSearchSuggestions: [
              StoredIngredient(id: 1, name: 'thyme'),
              StoredIngredient(id: 2, name: 'tomato'),
              StoredIngredient(id: 3, name: 'tortillas'),
            ],
          ),
          const EditPrepFormState(
            ingredientSearchSuggestions: [
              StoredIngredient(id: 2, name: 'tomato'),
              StoredIngredient(id: 3, name: 'tortillas'),
            ],
          ),
        ),
        stateListener(
          const EditPrepFormState(
            ingredientSearchSuggestions: [
              StoredIngredient(id: 2, name: 'tomato'),
              StoredIngredient(id: 3, name: 'tortillas'),
            ],
          ),
          const EditPrepFormState(
            ingredientSearchSuggestions: [
              StoredIngredient(id: 2, name: 'tomato'),
            ],
          ),
        ),
      ]);
    },
  );
}
