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
      const recipe = TransientRecipe(
        directions: [
          TransientDirection(
            description: 'description',
            temperature: Temperature.celsius(1.0),
            time: Duration(hours: 1),
            preps: [
              TransientPrep(
                ingredient: Ingredient(id: 1, name: '1'),
                amount: Count(1),
              ),
              TransientPrep(
                ingredient: Ingredient(id: 2, name: '2'),
                amount: Gram(1),
              ),
              TransientPrep(
                ingredient: Ingredient(id: 3, name: '3'),
                amount: Liter(1),
              ),
            ],
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
                  preps: [
                    Prep(
                      ingredient: Ingredient(id: 4, name: '4'),
                      amount: Count(2),
                    ),
                    Prep(
                      ingredient: Ingredient(id: 5, name: '5'),
                      amount: Milligram(2),
                    ),
                    Prep(
                      ingredient: Ingredient(id: 6, name: '6'),
                      amount: Milliliter(2),
                    ),
                  ],
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
    const ingredient = TransientIngredient(
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
                  Ingredient(
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
        late Ingredient addedIngredient;
        late Ingredient updatedIngredient;

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
