import 'package:data/data.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';
import 'package:domain/domain.dart';

void main() async {
  late RecipeLocalDatasource datasource;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    datasource = RecipeLocalDatasource();
  });

  tearDown(() async {
    final isar = await Isar.open([RecipeDataSchema, IngredientDataSchema]);
    await isar.writeTxn(() => isar.clear());
    await isar.close();
  });

  group(
    'Recipe',
    () {
      const recipe = Recipe(
        directions: [
          Direction(
            description: 'description',
            temperature: Temperature.celsius(1.0),
            time: Duration(hours: 1),
            countByIngredientId: {1: Count(1)},
            massByIngredientId: {2: Gram(1)},
            volumeByIngredientId: {3: Liter(1)},
          ),
        ],
        name: 'name',
        description: 'description',
        servings: 1,
      );

      group(
        'Add',
        () {
          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.addRecipe(recipe);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return added recipe object with id',
                () async {
                  final addedRecipe = await datasource.addRecipe(recipe);

                  expect(
                    addedRecipe,
                    Recipe(
                      name: recipe.name,
                      directions: recipe.directions,
                      description: recipe.description,
                      id: addedRecipe.id,
                      servings: recipe.servings,
                    ),
                  );
                },
              );
            },
          );
        },
      );

      group(
        'Read',
        () {
          late Recipe addedRecipe;

          setUp(() async {
            addedRecipe = await datasource.addRecipe(recipe);
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.getRecipe(addedRecipe.id!);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return read recipe object',
                () async {
                  expect(
                    await datasource.getRecipe(addedRecipe.id!),
                    addedRecipe,
                  );
                },
              );
            },
          );

          group(
            'Failed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.getRecipe(addedRecipe.id!);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should throw exception',
                () async {
                  expect(
                    datasource.getRecipe(-1),
                    throwsA(isA<DataNotFoundException>()),
                  );
                },
              );
            },
          );
        },
      );

      group(
        'Update',
        () {
          late Recipe addedRecipe;
          late Recipe updatedRecipe;

          setUp(() async {
            addedRecipe = await datasource.addRecipe(recipe);
            updatedRecipe = addedRecipe.copyWith(
              description: 'newDescription',
              directions: [
                Direction(
                  description: 'newDescription',
                  temperature: Temperature.celsius(2.0),
                  time: Duration(hours: 2),
                  countByIngredientId: {4: Count(2)},
                  massByIngredientId: {5: Milligram(2)},
                  volumeByIngredientId: {6: Milliliter(2)},
                ),
              ],
              name: 'newName',
              servings: 2,
            );
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.updateRecipe(updatedRecipe);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return updated recipe object',
                () async {
                  expect(
                    await datasource.updateRecipe(updatedRecipe),
                    updatedRecipe,
                  );
                },
              );
            },
          );
        },
      );

      test('should return recipe object match with the given id', () {});

      test(
        'should throw the exception when failed to find match data with the given id',
        () {},
      );

      test('Isar should be closed after searching the recipe', () {});

      test('the recipe should not be found after deletion', () {});

      test('Isar should be closed after updating the recipe', () {});

      test('the recipe should be changed after the update', () {});

      test('Isar should be closed after deleting the recipe', () {});
    },
  );

  group('[Ingredient]', () {
    test(
      'should return added ingredient object with id after adding the ingredient',
      () {},
    );

    test('Isar should be closed after adding the ingredient', () {});

    test('should return ingredient object match with the given id', () {});

    test(
      'should throw the exception when failed to find match data with the given id',
      () {},
    );

    test('Isar should be closed after searching the ingredient', () {});

    test('the ingredient should not be found after deletion', () {});

    test('Isar should be closed after updating the ingredient', () {});

    test('the ingredient should be changed after the update', () {});

    test('Isar should be closed after deleting the ingredient', () {});
  });
}
