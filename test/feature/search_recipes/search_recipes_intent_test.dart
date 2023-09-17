import 'package:cooking_calulator/feature/feature.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:data/model/model.dart';
import 'package:data/model/schema/schema.dart' as schema;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/error_mocks/error_recipe_local_datasource.dart';

part 'resources.dart';

const _databasePath = './';

class StateListener extends Mock {
  void call(SearchRecipesState? previous, SearchRecipesState next);
}

class EffectListener extends Mock {
  void call(SearchRecipesEffect? previous, SearchRecipesEffect? next);
}

void main() {
  late ProviderContainer container;
  late StateListener stateListener;
  late EffectListener effectListener;

  setUp(() async {
    stateListener = StateListener();
    effectListener = EffectListener();
    container = ProviderContainer(
      overrides: [
        recipeLocalDatasourceProvider.overrideWith(
          (ref) => RecipeLocalDatasource(_databasePath),
        ),
      ],
    )..listen<SearchRecipesState>(
        searchRecipesIntentProvider,
        stateListener,
      );

    await _initializeTestData();
  });

  tearDown(() async {
    await _clearTestData();
  });

  test(
    '레시피 목록을 pageable 하게 조회한다.',
    () async {
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setPage(page: 1, size: 2);

      verifyInOrder([
        stateListener(
          const SearchRecipesState(),
          const SearchRecipesState(isLoading: true, page: 1, size: 2),
        ),
        stateListener(
          const SearchRecipesState(isLoading: true, page: 1, size: 2),
          SearchRecipesState(
            isLoading: false,
            page: 1,
            size: 2,
            recipes: [_storedRecipes[2], _storedRecipes[3]],
          ),
        ),
      ]);
    },
  );

  test(
    '설정된 문자열로 시작하는 이름으로 레시피들을 검색한다.',
    () async {
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setName('recipe');
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setName('recipe2');
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setName('recipe22');

      verifyInOrder([
        stateListener(
          const SearchRecipesState(),
          const SearchRecipesState(isLoading: true, name: 'recipe'),
        ),
        stateListener(
          const SearchRecipesState(isLoading: true, name: 'recipe'),
          SearchRecipesState(
            isLoading: false,
            name: 'recipe',
            recipes: _storedRecipes,
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: false,
            name: 'recipe',
            recipes: _storedRecipes,
          ),
          SearchRecipesState(
            isLoading: true,
            name: 'recipe2',
            recipes: _storedRecipes,
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: true,
            name: 'recipe2',
            recipes: _storedRecipes,
          ),
          SearchRecipesState(
            isLoading: false,
            name: 'recipe2',
            recipes: [_storedRecipes[2], _storedRecipes[3]],
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: false,
            name: 'recipe2',
            recipes: [_storedRecipes[2], _storedRecipes[3]],
          ),
          SearchRecipesState(
            isLoading: true,
            name: 'recipe22',
            recipes: [_storedRecipes[2], _storedRecipes[3]],
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: true,
            name: 'recipe22',
            recipes: [_storedRecipes[2], _storedRecipes[3]],
          ),
          SearchRecipesState(
            isLoading: false,
            name: 'recipe22',
            recipes: [_storedRecipes[3]],
          ),
        ),
      ]);
    },
  );

  test(
    '설정된 재료를 포함하는 레시피들을 검색한다.',
    () async {
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setIngredientIds([1]);
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setIngredientIds([1, 3]);

      verifyInOrder([
        stateListener(
          const SearchRecipesState(),
          const SearchRecipesState(isLoading: true, ingredientIds: [1]),
        ),
        stateListener(
          const SearchRecipesState(isLoading: true, ingredientIds: [1]),
          SearchRecipesState(
            isLoading: false,
            ingredientIds: [1],
            recipes: [_storedRecipes[0], _storedRecipes[1], _storedRecipes[2]],
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: false,
            ingredientIds: [1],
            recipes: [_storedRecipes[0], _storedRecipes[1], _storedRecipes[2]],
          ),
          SearchRecipesState(
            isLoading: true,
            ingredientIds: [1, 3],
            recipes: [_storedRecipes[0], _storedRecipes[1], _storedRecipes[2]],
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: true,
            ingredientIds: [1, 3],
            recipes: [_storedRecipes[0], _storedRecipes[1], _storedRecipes[2]],
          ),
          SearchRecipesState(
            isLoading: false,
            ingredientIds: [1, 3],
            recipes: [_storedRecipes[2]],
          ),
        ),
      ]);
    },
  );

  test(
    '설정된 조리시간 이하의 레시피들을 검색한다.',
    () async {
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setCookingTime(const Duration(hours: 3));
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setCookingTime(const Duration(hours: 2));
      await container
          .read(searchRecipesIntentProvider.notifier)
          .setCookingTime(const Duration(hours: 1));

      verifyInOrder([
        stateListener(
          const SearchRecipesState(),
          const SearchRecipesState(
            isLoading: true,
            cookingTime: Duration(hours: 3),
          ),
        ),
        stateListener(
          const SearchRecipesState(
            isLoading: true,
            cookingTime: Duration(hours: 3),
          ),
          SearchRecipesState(
            isLoading: false,
            cookingTime: const Duration(hours: 3),
            recipes: _storedRecipes,
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: false,
            cookingTime: const Duration(hours: 3),
            recipes: _storedRecipes,
          ),
          SearchRecipesState(
            isLoading: true,
            cookingTime: const Duration(hours: 2),
            recipes: _storedRecipes,
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: true,
            cookingTime: const Duration(hours: 2),
            recipes: _storedRecipes,
          ),
          SearchRecipesState(
            isLoading: false,
            cookingTime: const Duration(hours: 2),
            recipes: [_storedRecipes[1], _storedRecipes[2], _storedRecipes[3]],
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: false,
            cookingTime: const Duration(hours: 2),
            recipes: [_storedRecipes[1], _storedRecipes[2], _storedRecipes[3]],
          ),
          SearchRecipesState(
            isLoading: true,
            cookingTime: const Duration(hours: 1),
            recipes: [_storedRecipes[1], _storedRecipes[2], _storedRecipes[3]],
          ),
        ),
        stateListener(
          SearchRecipesState(
            isLoading: true,
            cookingTime: const Duration(hours: 1),
            recipes: [_storedRecipes[1], _storedRecipes[2], _storedRecipes[3]],
          ),
          SearchRecipesState(
            isLoading: false,
            cookingTime: const Duration(hours: 1),
            recipes: [_storedRecipes[2], _storedRecipes[3]],
          ),
        ),
      ]);
    },
  );

  test(
    '설정된 조리시간 이하의 레시피 중 설정된 재료들을 포함하며 설정된 문자열로 시작하는 이름을 가진 레시피들을 pagable 하게 검색한다.',
    () async {
      const name = 'recipe';
      const cookingTime = Duration(hours: 2);
      const ingredientIds = [3];
      const size = 1;
      const page = 1;

      final provider = container.read(searchRecipesIntentProvider.notifier);
      await provider.setName(name);
      await provider.setCookingTime(cookingTime);
      await provider.setIngredientIds(ingredientIds);
      await provider.setPage(size: size, page: page);

      expect(
        provider.state,
        SearchRecipesState(
          name: name,
          cookingTime: cookingTime,
          ingredientIds: ingredientIds,
          size: size,
          page: page,
          recipes: [_storedRecipes[3]],
        ),
      );
    },
  );

  group(
    '실패 케이스',
    () {
      setUp(() {
        container = ProviderContainer(
          overrides: [
            recipeLocalDatasourceProvider.overrideWith(
              (ref) => ErrorRecipeLocalDatasource(),
            ),
          ],
        )
          ..listen<SearchRecipesState>(
            searchRecipesIntentProvider,
            stateListener,
          )
          ..listen<SearchRecipesEffect?>(
            searchRecipesEffectProvider,
            effectListener,
          );
      });

      test(
        '레시피 목록 조회에 실패하면 스낵바가 노출되며 상태가 롤백된다.',
        () async {
          await container.read(searchRecipesIntentProvider.notifier).setPage(
                page: 1,
                size: 1,
              );
          verifyInOrder([
            stateListener(
              const SearchRecipesState(),
              const SearchRecipesState(isLoading: true, page: 1, size: 1),
            ),
            stateListener(
              const SearchRecipesState(isLoading: true, page: 1, size: 1),
              const SearchRecipesState(),
            ),
            effectListener(
              null,
              SearchRecipesEffect.showErrorSnackBar(Exception().toString()),
            ),
          ]);
        },
      );

      test(
        '이름으로 검색에 실패하면 스낵바가 노출되며 상태가 롤백된다.',
        () async {
          await container
              .read(searchRecipesIntentProvider.notifier)
              .setName('recipe');
          verifyInOrder([
            stateListener(
              const SearchRecipesState(),
              const SearchRecipesState(isLoading: true, name: 'recipe'),
            ),
            stateListener(
              const SearchRecipesState(isLoading: true, name: 'recipe'),
              const SearchRecipesState(),
            ),
            effectListener(
              null,
              SearchRecipesEffect.showErrorSnackBar(Exception().toString()),
            ),
          ]);
        },
      );

      test(
        '재료로 검색에 실패하면 스낵바가 노출되며 상태가 롤백된다.',
        () async {
          await container
              .read(searchRecipesIntentProvider.notifier)
              .setIngredientIds([1]);
          verifyInOrder([
            stateListener(
              const SearchRecipesState(),
              const SearchRecipesState(isLoading: true, ingredientIds: [1]),
            ),
            stateListener(
              const SearchRecipesState(isLoading: true, ingredientIds: [1]),
              const SearchRecipesState(),
            ),
            effectListener(
              null,
              SearchRecipesEffect.showErrorSnackBar(Exception().toString()),
            ),
          ]);
        },
      );

      test(
        '조리시간으로 검색에 실패하면 스낵바가 노출되며 상태가 롤백된다.',
        () async {
          await container
              .read(searchRecipesIntentProvider.notifier)
              .setCookingTime(const Duration(hours: 1));
          verifyInOrder([
            stateListener(
              const SearchRecipesState(),
              const SearchRecipesState(
                isLoading: true,
                cookingTime: Duration(hours: 1),
              ),
            ),
            stateListener(
              const SearchRecipesState(
                isLoading: true,
                cookingTime: Duration(hours: 1),
              ),
              const SearchRecipesState(),
            ),
            effectListener(
              null,
              SearchRecipesEffect.showErrorSnackBar(Exception().toString()),
            ),
          ]);
        },
      );
    },
  );
}

Future<void> _initializeTestData() async {
  final isar = await Isar.open(
    [schema.RecipeSchema, schema.IngredientSchema],
    directory: _databasePath,
  );
  await isar.writeTxn(() async {
    await isar.ingredients.putAll(_ingredientSchemas);
    await isar.recipes.putAll(_recipeSchemas);
  });
  await isar.close();
}

Future<void> _clearTestData() async {
  final isar = await Isar.open(
    [schema.RecipeSchema, schema.IngredientSchema],
    directory: _databasePath,
  );
  await isar.writeTxn(isar.clear);
  await isar.close();
}
