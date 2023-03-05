import 'package:data/data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'cached_recipe_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RecipeDatasource>()])
void main() {
  const initialRecipeId = 1;
  const initialRecipe = IndexedRecipe(
    directions: [],
    id: 1,
    name: 'name',
    description: 'description',
    servings: 1,
  );
  const initialCache = {initialRecipeId: initialRecipe};
  const newRecipe = Recipe(
    directions: [],
    name: 'newName',
    description: 'newDescription',
    servings: 1,
  );
  const newIndexedRecipe = IndexedRecipe(
    directions: [],
    id: 2,
    name: 'newName',
    description: 'newDescription',
    servings: 1,
  );

  late ProviderContainer container;
  late MockRecipeDatasource recipeDatasource;
  late CachedRecipeRepository repository;

  setUp(() {
    recipeDatasource = MockRecipeDatasource();
    when(recipeDatasource.addRecipe(newRecipe)).thenAnswer(
      (_) async => newIndexedRecipe,
    );
    when(recipeDatasource.getRecipe(initialRecipeId)).thenAnswer(
      (_) async => initialRecipe,
    );
    when(recipeDatasource.getAllRecipes()).thenAnswer(
      (_) async => initialCache.values.toList(),
    );

    container = ProviderContainer(overrides: [
      recipeDatasourceProvider.overrideWith((_) => recipeDatasource),
    ]);
    repository = container.read(cachedRecipeRepositoryProvider.notifier);
  });

  group(
    'Add recipe',
    () {
      test(
        'should return added data',
        () async {
          expect(
            await repository.addRecipe(newRecipe),
            newIndexedRecipe,
          );
        },
      );

      test(
        'should cache added data',
        () async {
          await repository.addRecipe(newRecipe);

          expect(
            container
                .read(cachedRecipeRepositoryProvider)
                .value?[newIndexedRecipe.id],
            newIndexedRecipe,
          );
        },
      );
    },
  );

  group(
    'Get all recipes >',
    () {
      group(
        'If has cached data >',
        () {
          test(
            'Should return cached data if it exists',
            () async {
              expect(
                await repository.getAllRecipes(),
                initialCache.values.toList(),
              );
            },
          );
        },
      );

      group(
        'If no cached data >',
        () {
          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            when(recipeDatasource.getAllRecipes()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );

            container = ProviderContainer(overrides: [
              recipeDatasourceProvider.overrideWith((_) => recipeDatasource),
            ]);
            repository = container.read(
              cachedRecipeRepositoryProvider.notifier,
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getAllRecipes();

              expect(
                container.read(cachedRecipeRepositoryProvider).value,
                initialCache,
              );
            },
          );

          test(
            'should return fetched data if there\'s no cached data',
            () async {
              expect(
                await repository.getAllRecipes(),
                initialCache.values.toList(),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Get recipe',
    () {
      group(
        'If has cached data >',
        () {
          test(
            'Should return cached data if it exists',
            () async {
              expect(
                await repository.getRecipe(initialRecipeId),
                initialRecipe,
              );
            },
          );
        },
      );

      group(
        'If no cached data >',
        () {
          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            when(recipeDatasource.getAllRecipes()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );
            when(
              recipeDatasource.getRecipe(initialCache.entries.first.key),
            ).thenAnswer(
              (_) async => initialCache.entries.first.value,
            );

            container = ProviderContainer(overrides: [
              recipeDatasourceProvider.overrideWith((_) => recipeDatasource),
            ]);
            repository = container.read(
              cachedRecipeRepositoryProvider.notifier,
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getRecipe(initialRecipeId);

              expect(
                container.read(cachedRecipeRepositoryProvider).value,
                initialCache,
              );
            },
          );

          test(
            'should return fetched data if there\'s no cached data',
            () async {
              expect(
                await repository.getRecipe(initialRecipeId),
                initialRecipe,
              );
            },
          );
        },
      );
    },
  );

  group(
    'Update recipe',
    () {
      const updatedRecipe = IndexedRecipe(
        directions: [],
        id: initialRecipeId,
        name: 'updatedName',
        description: 'updatedDescription',
        servings: 1,
      );

      setUp(() {
        when(recipeDatasource.updateRecipe(updatedRecipe))
            .thenAnswer((_) async => updatedRecipe);
      });

      test(
        'should return updated data',
        () async {
          expect(
            await repository.updateRecipe(updatedRecipe),
            updatedRecipe,
          );
        },
      );

      test(
        'should update cache',
        () async {
          await repository.updateRecipe(updatedRecipe);

          expect(
            container.read(cachedRecipeRepositoryProvider).value,
            {initialRecipeId: updatedRecipe},
          );
        },
      );
    },
  );

  group(
    'Delete recipe',
    () {
      test(
        'should delete cache',
        () async {
          await repository.deleteRecipe(initialRecipeId);

          expect(
            container.read(cachedRecipeRepositoryProvider).value,
            isEmpty,
          );
        },
      );
    },
  );
}
