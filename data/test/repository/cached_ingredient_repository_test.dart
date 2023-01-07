import 'package:data/datasource/recipe_datasource.dart';
import 'package:data/provider/provider.dart';
import 'package:data/repository/repository.dart';
import 'package:domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'cached_ingredient_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RecipeDatasource>()])
void main() {
  const initialIngredientId = 1;
  const initialIngredient = IndexedIngredient(
    id: 1,
    name: 'name',
    description: 'description',
  );
  const initialCache = {initialIngredientId: initialIngredient};
  const newIngredient = Ingredient(
    name: 'newName',
    description: 'newDescription',
  );
  const newIndexedIngredient = IndexedIngredient(
    id: 2,
    name: 'newName',
    description: 'newDescription',
  );

  late ProviderContainer container;
  late MockRecipeDatasource recipeDatasource;
  late CachedIngredientRepository repository;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        cachedIngredientRepositoryProvider.overrideWith(
          (ref) {
            recipeDatasource = MockRecipeDatasource();

            when(recipeDatasource.addIngredient(newIngredient)).thenAnswer(
              (_) async => newIndexedIngredient,
            );

            return CachedIngredientRepository(
              recipeDatasource: recipeDatasource,
              initialCache: initialCache,
            );
          },
        ),
      ],
    );
    repository = container.read(cachedIngredientRepositoryProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group(
    'Add ingredient',
    () {
      test(
        'should return added data',
        () async {
          expect(
            await repository.addIngredient(newIngredient),
            newIndexedIngredient,
          );
        },
      );

      test(
        'should cache added data',
        () async {
          await repository.addIngredient(newIngredient);

          expect(
            repository.debugState[newIndexedIngredient.id],
            newIndexedIngredient,
          );
        },
      );
    },
  );

  group(
    'Get all ingredients >',
    () {
      group(
        'If has cached data >',
        () {
          test(
            'Should return cached data if it exists',
            () async {
              expect(
                await repository.getAllIngredients(),
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
          late CachedIngredientRepository repository;

          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            container = ProviderContainer(overrides: [
              cachedIngredientRepositoryProvider.overrideWith(
                (ref) => CachedIngredientRepository(
                  recipeDatasource: recipeDatasource,
                ),
              ),
            ]);
            repository = container.read(
              cachedIngredientRepositoryProvider.notifier,
            );

            when(recipeDatasource.getAllIngredients()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getAllIngredients();

              expect(repository.debugState, initialCache);
            },
          );

          test(
            'should return fetched data if there\'s no cached data',
            () async {
              expect(
                await repository.getAllIngredients(),
                initialCache.values.toList(),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Get ingredient',
    () {
      group(
        'If has cached data >',
        () {
          test(
            'Should return cached data if it exists',
            () async {
              expect(
                await repository.getIngredient(initialIngredientId),
                initialIngredient,
              );
            },
          );
        },
      );

      group(
        'If no cached data >',
        () {
          late ProviderContainer container;
          late CachedIngredientRepository repository;

          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            container = ProviderContainer(overrides: [
              cachedIngredientRepositoryProvider.overrideWith(
                (ref) => CachedIngredientRepository(
                  recipeDatasource: recipeDatasource,
                ),
              ),
            ]);
            repository = container.read(
              cachedIngredientRepositoryProvider.notifier,
            );

            when(recipeDatasource.getAllIngredients()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );
            when(
              recipeDatasource.getIngredient(initialCache.entries.first.key),
            ).thenAnswer(
              (_) async => initialCache.entries.first.value,
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getIngredient(initialIngredientId);

              expect(repository.debugState, initialCache);
            },
          );

          test(
            'should return fetched data if there\'s no cached data',
            () async {
              expect(
                await repository.getIngredient(initialIngredientId),
                initialIngredient,
              );
            },
          );
        },
      );
    },
  );

  group(
    'Update ingredient',
    () {
      const updatedIngredient = IndexedIngredient(
        id: initialIngredientId,
        name: 'updatedName',
        description: 'updatedDescription',
      );

      setUp(() {
        when(recipeDatasource.updateIngredient(updatedIngredient))
            .thenAnswer((_) async => updatedIngredient);
      });

      test(
        'should return updated data',
        () async {
          expect(
            await repository.updateIngredient(updatedIngredient),
            updatedIngredient,
          );
        },
      );

      test(
        'should update cache',
        () async {
          await repository.updateIngredient(updatedIngredient);

          expect(
            repository.debugState,
            {initialIngredientId: updatedIngredient},
          );
        },
      );
    },
  );

  group(
    'Delete ingredient',
    () {
      test(
        'should delete cache',
        () async {
          await repository.deleteIngredient(initialIngredientId);

          expect(repository.debugState, isEmpty);
        },
      );
    },
  );
}
