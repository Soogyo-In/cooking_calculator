import 'package:data/datasource/recipe_datasource.dart';
import 'package:data/provider/provider.dart';
import 'package:data/repository/repository.dart';
import 'package:domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'cached_recip_repository_test.mocks.dart';

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
    container = ProviderContainer(
      overrides: [
        cachedRecipeRepositoryProvider.overrideWith(
          (ref) {
            recipeDatasource = MockRecipeDatasource();

            when(recipeDatasource.addRecipe(newRecipe)).thenAnswer(
              (_) async => newIndexedRecipe,
            );

            return CachedRecipeRepository(
              recipeDatasource: recipeDatasource,
              initialCache: initialCache,
            );
          },
        ),
      ],
    );
    repository = container.read(cachedRecipeRepositoryProvider.notifier);
  });

  tearDown(() {
    container.dispose();
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
            repository.debugState[newIndexedRecipe.id],
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
          late ProviderContainer container;
          late CachedRecipeRepository repository;

          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            container = ProviderContainer(overrides: [
              cachedRecipeRepositoryProvider.overrideWith(
                (ref) => CachedRecipeRepository(
                  recipeDatasource: recipeDatasource,
                ),
              ),
            ]);
            repository = container.read(
              cachedRecipeRepositoryProvider.notifier,
            );

            when(recipeDatasource.getAllRecipes()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getAllRecipes();

              expect(repository.debugState, initialCache);
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
          late ProviderContainer container;
          late CachedRecipeRepository repository;

          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            container = ProviderContainer(overrides: [
              cachedRecipeRepositoryProvider.overrideWith(
                (ref) => CachedRecipeRepository(
                  recipeDatasource: recipeDatasource,
                ),
              ),
            ]);
            repository = container.read(
              cachedRecipeRepositoryProvider.notifier,
            );

            when(recipeDatasource.getAllRecipes()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );
            when(
              recipeDatasource.getRecipe(initialCache.entries.first.key),
            ).thenAnswer(
              (_) async => initialCache.entries.first.value,
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getRecipe(initialRecipeId);

              expect(repository.debugState, initialCache);
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
            repository.debugState,
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

          expect(repository.debugState, isEmpty);
        },
      );
    },
  );
}
