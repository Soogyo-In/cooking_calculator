import 'package:cooking_calulator/feature/edit_recipe/edit_recipe_feature.dart';
import 'package:cooking_calulator/feature/feature.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:data/model/schema/schema.dart' as schema;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.dart';

class StateListener extends Mock {
  void call(EditRecipeState? previous, EditRecipeState next);
}

class EffectListener extends Mock {
  void call(EditRecipeEffect? previous, EditRecipeEffect? next);
}

const databasePath = './';

void main() {
  late RecipeLocalDatasource datasource;
  late ProviderContainer container;
  late StateListener stateListener;
  late EffectListener effectListener;

  setUp(() async {
    datasource = RecipeLocalDatasource(databasePath);
    stateListener = StateListener();
    effectListener = EffectListener();
    container = ProviderContainer(
      overrides: [
        recipeLocalDatasourceProvider.overrideWith((ref) => datasource),
      ],
    )
      ..listen<EditRecipeState>(
        editRecipeIntentProvider,
        stateListener.call,
        fireImmediately: true,
      )
      ..listen<EditRecipeEffect?>(
        editRecipeEffectProvider,
        effectListener.call,
        fireImmediately: true,
      );
  });

  tearDown(() async {
    final isar = await Isar.open(
      [schema.RecipeSchema, schema.IngredientSchema],
      directory: databasePath,
    );
    await isar.writeTxn(() => isar.clear());
    await isar.close();

    container.dispose();
  });

  test(
    '레시피를 저장한다.',
    () async {
      const recipe = Recipe();
      await container.read(editRecipeIntentProvider.notifier).addRecipe(recipe);

      final isar = await Isar.open(
        [schema.RecipeSchema, schema.IngredientSchema],
        directory: databasePath,
      );

      final storedRecipe = await isar.recipes.get(1);
      await isar.close();

      expect(storedRecipe, const schema.Recipe(id: 1, name: ''));

      verifyInOrder([
        stateListener(
          const EditRecipeState(isLoading: false),
          const EditRecipeState(isLoading: true),
        ),
        effectListener(
          null,
          const EditRecipeEffect.navigateBack(),
        ),
        stateListener(
          const EditRecipeState(isLoading: true),
          const EditRecipeState(isLoading: false),
        ),
      ]);
    },
  );

  test(
    '레시피를 수정한다.',
    () async {
      Isar isar = await Isar.open(
        [schema.RecipeSchema, schema.IngredientSchema],
        directory: databasePath,
      );
      await isar.writeTxn(
        () => isar.recipes.put(const schema.Recipe(name: 'name')),
      );
      await isar.close();

      const recipe = StoredRecipe(id: 1, name: 'newName');
      await container
          .read(editRecipeIntentProvider.notifier)
          .updateRecipe(id: recipe.id, recipe: recipe);

      isar = await Isar.open(
        [schema.RecipeSchema, schema.IngredientSchema],
        directory: databasePath,
      );
      final storedRecipe = await isar.recipes.get(1);
      await isar.close();

      expect(storedRecipe, const schema.Recipe(id: 1, name: 'newName'));

      verifyInOrder([
        stateListener(
          const EditRecipeState(isLoading: false),
          const EditRecipeState(isLoading: true),
        ),
        effectListener(
          null,
          const EditRecipeEffect.navigateBack(),
        ),
        stateListener(
          const EditRecipeState(isLoading: true),
          const EditRecipeState(isLoading: false),
        ),
      ]);
    },
  );

  test(
    '레시피를 제거한다.',
    () async {
      Isar isar = await Isar.open(
        [schema.RecipeSchema, schema.IngredientSchema],
        directory: databasePath,
      );
      await isar.writeTxn(
        () => isar.recipes.put(const schema.Recipe(name: 'name')),
      );
      await isar.close();

      await container.read(editRecipeIntentProvider.notifier).deleteRecipe(1);

      isar = await Isar.open(
        [schema.RecipeSchema, schema.IngredientSchema],
        directory: databasePath,
      );
      final storedRecipe = await isar.recipes.get(1);
      await isar.close();

      expect(storedRecipe, isNull);

      verifyInOrder([
        stateListener(
          const EditRecipeState(isLoading: false),
          const EditRecipeState(isLoading: true),
        ),
        effectListener(
          null,
          const EditRecipeEffect.navigateBack(),
        ),
        stateListener(
          const EditRecipeState(isLoading: true),
          const EditRecipeState(isLoading: false),
        ),
      ]);
    },
  );

  group(
    '실패 케이스',
    () {
      setUp(() {
        datasource = ErrorRecipeLocalDatasource();
        container = ProviderContainer(
          overrides: [
            recipeLocalDatasourceProvider.overrideWith((ref) => datasource),
          ],
        )
          ..listen<EditRecipeState>(
            editRecipeIntentProvider,
            stateListener.call,
            fireImmediately: true,
          )
          ..listen<EditRecipeEffect?>(
            editRecipeEffectProvider,
            effectListener.call,
            fireImmediately: true,
          );
      });

      test(
        '레시피 저장에 실패하면 스낵바가 노출된다.',
        () async {
          const recipe = Recipe();
          await container
              .read(editRecipeIntentProvider.notifier)
              .addRecipe(recipe);

          verifyInOrder([
            stateListener(
              const EditRecipeState(isLoading: false),
              const EditRecipeState(isLoading: true),
            ),
            effectListener(
              null,
              EditRecipeEffect.showErrorSnackBar(Exception().toString()),
            ),
            stateListener(
              const EditRecipeState(isLoading: true),
              const EditRecipeState(isLoading: false),
            ),
          ]);
        },
      );

      test(
        '레시피 수정에 실패하면 스낵바가 노출된다.',
        () async {
          const recipe = StoredRecipe(id: 1);
          await container
              .read(editRecipeIntentProvider.notifier)
              .updateRecipe(id: recipe.id, recipe: recipe);

          verifyInOrder([
            stateListener(
              const EditRecipeState(isLoading: false),
              const EditRecipeState(isLoading: true),
            ),
            effectListener(
              null,
              EditRecipeEffect.showErrorSnackBar(Exception().toString()),
            ),
            stateListener(
              const EditRecipeState(isLoading: true),
              const EditRecipeState(isLoading: false),
            ),
          ]);
        },
      );

      test(
        '레시피 제거에 실패하면 스낵바가 노출된다.',
        () async {
          const recipe = StoredRecipe(id: 1);
          await container
              .read(editRecipeIntentProvider.notifier)
              .deleteRecipe(recipe.id);

          verifyInOrder([
            stateListener(
              const EditRecipeState(isLoading: false),
              const EditRecipeState(isLoading: true),
            ),
            effectListener(
              null,
              EditRecipeEffect.showErrorSnackBar(Exception().toString()),
            ),
            stateListener(
              const EditRecipeState(isLoading: true),
              const EditRecipeState(isLoading: false),
            ),
          ]);
        },
      );
    },
  );
}
