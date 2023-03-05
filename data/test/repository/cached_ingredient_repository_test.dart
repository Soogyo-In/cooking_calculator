import 'package:data/data.dart';
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
    recipeDatasource = MockRecipeDatasource();
    when(recipeDatasource.addIngredient(any)).thenAnswer(
      (_) async => newIndexedIngredient,
    );
    when(recipeDatasource.getIngredient(initialIngredientId)).thenAnswer(
      (_) async => initialIngredient,
    );
    when(recipeDatasource.getAllIngredients()).thenAnswer(
      (_) async => initialCache.values.toList(),
    );

    container = ProviderContainer(overrides: [
      recipeDatasourceProvider.overrideWith((_) => recipeDatasource),
    ]);
    repository = container.read(cachedIngredientRepositoryProvider.notifier);
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
            container
                .read(cachedIngredientRepositoryProvider)
                .value?[newIndexedIngredient.id],
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
          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            when(recipeDatasource.getAllIngredients()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );

            container = ProviderContainer(
              overrides: [
                recipeDatasourceProvider.overrideWith((_) => recipeDatasource),
              ],
            );
            repository = container.read(
              cachedIngredientRepositoryProvider.notifier,
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getAllIngredients();

              expect(
                container.read(cachedIngredientRepositoryProvider).value,
                initialCache,
              );
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
          setUp(() {
            recipeDatasource = MockRecipeDatasource();
            when(recipeDatasource.getAllIngredients()).thenAnswer(
              (_) async => initialCache.values.toList(),
            );
            when(
              recipeDatasource.getIngredient(initialCache.entries.first.key),
            ).thenAnswer(
              (_) async => initialCache.entries.first.value,
            );

            container = ProviderContainer(
              overrides: [
                recipeDatasourceProvider.overrideWith((_) => recipeDatasource),
              ],
            );
            repository = container.read(
              cachedIngredientRepositoryProvider.notifier,
            );
          });

          test(
            'should cache fetched data if there\'s no cached data',
            () async {
              await repository.getIngredient(initialIngredientId);

              expect(
                container.read(cachedIngredientRepositoryProvider).value,
                initialCache,
              );
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
            container.read(cachedIngredientRepositoryProvider).value,
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

          expect(
            container.read(cachedIngredientRepositoryProvider).value,
            isEmpty,
          );
        },
      );
    },
  );
}
