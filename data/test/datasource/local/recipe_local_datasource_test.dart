import 'package:data/data.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';

void main() async {
  late RecipeLocalDatasource datasource;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    datasource = RecipeLocalDatasource('');
  });

  tearDown(() async {
    final isar = await Isar.open(
      [RecipeDataSchema, IngredientDataSchema],
      directory: '',
    );
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
                    IndexedRecipe(
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
          late IndexedRecipe addedRecipe;

          setUp(() async {
            addedRecipe = await datasource.addRecipe(recipe);
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.getRecipe(addedRecipe.id);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return read recipe object',
                () async {
                  expect(
                    await datasource.getRecipe(addedRecipe.id),
                    addedRecipe,
                  );
                },
              );
            },
          );

          group(
            'Failed',
            () {
              const invalidId = -1;

              test(
                'Should Isar instance is closed',
                () async {
                  try {
                    await datasource.getRecipe(invalidId);
                  } catch (e) {
                    expect(Isar.getInstance(), isNull);
                  }
                },
              );

              test(
                'Should throw exception',
                () async {
                  expect(
                    datasource.getRecipe(invalidId),
                    throwsA(isA<DataNotFoundException>()),
                  );
                },
              );
            },
          );
        },
      );

      group(
        'Read all',
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
                  await datasource.getAllRecipes();

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return read recipe objects',
                () async {
                  expect(
                    await datasource.getAllRecipes(),
                    [addedRecipe],
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
          late IndexedRecipe addedRecipe;
          late IndexedRecipe updatedRecipe;

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

      group(
        'Delete',
        () {
          late IndexedRecipe addedRecipe;

          setUp(() async {
            addedRecipe = await datasource.addRecipe(recipe);
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.deleteRecipe(addedRecipe.id);

                  expect(Isar.getInstance(), isNull);
                },
              );
            },
          );
        },
      );
    },
  );

  group('Ingredient', () {
    const ingredient = Ingredient(
      name: 'name',
      description: 'description',
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
                await datasource.addIngredient(ingredient);

                expect(Isar.getInstance(), isNull);
              },
            );

            test(
              'Should return added ingredient object with id',
              () async {
                final addedIngredient =
                    await datasource.addIngredient(ingredient);

                expect(
                  addedIngredient,
                  IndexedIngredient(
                    name: ingredient.name,
                    description: ingredient.description,
                    id: addedIngredient.id,
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
        late IndexedIngredient addedIngredient;

        setUp(() async {
          addedIngredient = await datasource.addIngredient(ingredient);
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.getIngredient(addedIngredient.id);

                expect(Isar.getInstance(), isNull);
              },
            );

            test(
              'Should return read ingredient object',
              () async {
                expect(
                  await datasource.getIngredient(addedIngredient.id),
                  addedIngredient,
                );
              },
            );
          },
        );

        group(
          'Failed',
          () {
            const invalidId = -1;

            test(
              'Should Isar instance is closed',
              () async {
                try {
                  await datasource.getIngredient(invalidId);
                } catch (e) {
                  expect(Isar.getInstance(), isNull);
                }
              },
            );

            test(
              'Should throw exception',
              () async {
                expect(
                  datasource.getIngredient(invalidId),
                  throwsA(isA<DataNotFoundException>()),
                );
              },
            );
          },
        );
      },
    );

    group(
      'Read all',
      () {
        late Ingredient addedIngredient;

        setUp(() async {
          addedIngredient = await datasource.addIngredient(ingredient);
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.getAllIngredients();

                expect(Isar.getInstance(), isNull);
              },
            );

            test(
              'Should return read ingredient objects',
              () async {
                expect(
                  await datasource.getAllIngredients(),
                  [addedIngredient],
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
        late IndexedIngredient addedIngredient;
        late IndexedIngredient updatedIngredient;

        setUp(() async {
          addedIngredient = await datasource.addIngredient(ingredient);
          updatedIngredient = addedIngredient.copyWith(
            description: 'newDescription',
            name: 'newName',
          );
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.updateIngredient(updatedIngredient);

                expect(Isar.getInstance(), isNull);
              },
            );

            test(
              'Should return updated ingredient object',
              () async {
                expect(
                  await datasource.updateIngredient(updatedIngredient),
                  updatedIngredient,
                );
              },
            );
          },
        );
      },
    );

    group(
      'Delete',
      () {
        late IndexedIngredient addedIngredient;

        setUp(() async {
          addedIngredient = await datasource.addIngredient(ingredient);
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.deleteIngredient(addedIngredient.id);

                expect(Isar.getInstance(), isNull);
              },
            );
          },
        );
      },
    );
  });
}
