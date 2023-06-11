import 'package:data/data.dart';
import 'package:domain/domain.dart' as domain;
import 'package:isar/isar.dart';
import 'package:ktc_dart/ktc_dart.dart';
import 'package:test/test.dart';

void main() async {
  const databasePath = './';
  late RecipeLocalDatasource datasource;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    datasource = RecipeLocalDatasource(databasePath);
  });

  tearDown(() async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );
    await isar.writeTxn(() => isar.clear());
    await isar.close();
  });

  group(
    'Recipe',
    () {
      final domainDirection = domain.Direction(
        description: 'description',
        temperature: domain.Temperature.celsius(1.0),
        time: Duration(hours: 1),
        preps: [
          domain.Prep(
            ingredient: domain.Ingredient(name: '1'),
            amount: domain.Count(1.0),
          ),
          domain.Prep(
            ingredient: domain.Ingredient(name: '2'),
            amount: domain.Gram(1.0),
          ),
          domain.Prep(
            ingredient: domain.Ingredient(name: '3'),
            amount: domain.Liter(1.0),
          ),
        ],
      );
      final domainRecipe = domain.Recipe(
        directions: [domainDirection],
        name: 'name',
        description: 'description',
        servings: 1,
      );

      final dataRecipe = Recipe(
        id: 1,
        description: domainDirection.description,
        directions: [
          Direction(
            description: domainDirection.description,
            preps: domainDirection.preps
                .mapIndexed((index, prep) => Prep(
                      ingredientId: index + 1,
                      unit: prep.amount.toMatterUnit(),
                      value: prep.amount.value,
                    ))
                .toList(),
            temperature: domainDirection.temperature?.toDataModel(),
            timeInSeconds: domainDirection.time.inSeconds,
          ),
        ],
        name: domainRecipe.name,
        servings: domainRecipe.servings,
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
                  await datasource.addRecipe(domainRecipe);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return added recipe id',
                () async {
                  final addedRecipeId =
                      await datasource.addRecipe(domainRecipe);
                  final isar = await Isar.open(
                    [RecipeSchema],
                    directory: databasePath,
                  );
                  final addedRecipe = await isar.recipes.get(addedRecipeId);

                  await isar.close();

                  expect(addedRecipe, dataRecipe);
                },
              );
            },
          );
        },
      );

      group(
        'Read',
        () {
          late Id addedRecipeId;

          setUp(() async {
            final isar = await Isar.open(
              [RecipeSchema, IngredientSchema],
              directory: databasePath,
            );
            isar.writeTxn(
              () async {
                await isar.ingredients.putAll(
                  domainRecipe.directions
                      .expand((direction) => direction.preps)
                      .map((prep) => prep.ingredient)
                      .map((ingredient) => Ingredient(
                            description: ingredient.description,
                            name: ingredient.name,
                          ))
                      .toList(),
                );
                addedRecipeId = await isar.recipes.put(dataRecipe);
              },
            );

            await isar.close();
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.getRecipe(addedRecipeId);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return read recipe object',
                () async {
                  expect(
                    await datasource.getRecipe(addedRecipeId),
                    domain.StoredRecipe(
                      id: addedRecipeId,
                      name: domainRecipe.name,
                      directions: domainRecipe.directions,
                      description: domainRecipe.description,
                      servings: domainRecipe.servings,
                    ),
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
          late Id addedRecipeId;

          setUp(() async {
            addedRecipeId = await datasource.addRecipe(domainRecipe);
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
                    [
                      domain.StoredRecipe(
                        id: addedRecipeId,
                        directions: domainRecipe.directions,
                        name: domainRecipe.name,
                        description: domainRecipe.description,
                        servings: domainRecipe.servings,
                      ),
                    ],
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
          late Id recipeId;
          final updatedDirection = domain.Direction(
            description: 'newDescription',
            temperature: domain.Temperature.celsius(2.0),
            time: Duration(hours: 2),
            preps: [
              domain.Prep(
                ingredient: domain.Ingredient(name: '2'),
                amount: domain.Count(2),
              ),
              domain.Prep(
                ingredient: domain.Ingredient(name: '3'),
                amount: domain.Milligram(2),
              ),
              domain.Prep(
                ingredient: domain.Ingredient(name: '4'),
                amount: domain.Milliliter(2),
              ),
            ],
          );
          final updatedRecipe = domain.Recipe(
            description: 'newDescription',
            directions: [updatedDirection],
            name: 'newName',
            servings: 2,
          );
          final updatedRecipeData = Recipe(
            id: 1,
            description: updatedRecipe.description,
            directions: [
              Direction(
                description: updatedDirection.description,
                temperature: updatedDirection.temperature?.toDataModel(),
                timeInSeconds: updatedDirection.time.inSeconds,
                preps: updatedDirection.preps
                    .mapIndexed((index, prep) => Prep(
                          ingredientId: index + 2,
                          unit: prep.amount.toMatterUnit(),
                          value: prep.amount.value,
                        ))
                    .toList(),
              ),
            ],
            name: updatedRecipe.name,
            servings: updatedRecipe.servings,
          );

          setUp(() async {
            recipeId = await datasource.addRecipe(domainRecipe);
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.updateRecipe(
                    id: recipeId,
                    recipe: updatedRecipe,
                  );

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return updated recipe object',
                () async {
                  await datasource.updateRecipe(
                    id: recipeId,
                    recipe: updatedRecipe,
                  );

                  final isar = await Isar.open(
                    [RecipeSchema],
                    directory: databasePath,
                  );
                  final updateRecipeFromDatabase = await isar.recipes.get(
                    recipeId,
                  );

                  await isar.close();

                  expect(
                    updateRecipeFromDatabase,
                    updatedRecipeData,
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
          late Id addedRecipeId;

          setUp(() async {
            addedRecipeId = await datasource.addRecipe(domainRecipe);
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.deleteRecipe(addedRecipeId);

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
    const ingredient = domain.Ingredient(
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
              'Should return added ingredient id',
              () async {
                final id = await datasource.addIngredient(ingredient);

                final isar = await Isar.open(
                  [IngredientSchema],
                  directory: databasePath,
                );

                final addedIngredient = await isar.ingredients.get(id);

                await isar.close();

                expect(
                  addedIngredient,
                  Ingredient(
                    id: id,
                    name: ingredient.name,
                    description: ingredient.description,
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
        late Id addedIngredientId;

        setUp(() async {
          addedIngredientId = await datasource.addIngredient(ingredient);
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.getIngredient(addedIngredientId);

                expect(Isar.getInstance(), isNull);
              },
            );

            test(
              'Should return read ingredient object',
              () async {
                expect(
                  await datasource.getIngredient(addedIngredientId),
                  domain.StoredIngredient(
                    id: addedIngredientId,
                    name: ingredient.name,
                    description: ingredient.description,
                  ),
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
        late Id addedIngredientId;

        setUp(() async {
          addedIngredientId = await datasource.addIngredient(ingredient);
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
                  [
                    domain.StoredIngredient(
                      id: addedIngredientId,
                      name: ingredient.name,
                      description: ingredient.description,
                    )
                  ],
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
        const updatedIngredient = domain.Ingredient(
          description: 'newDescription',
          name: 'newName',
        );
        late Id ingredientId;

        setUp(() async {
          ingredientId = await datasource.addIngredient(ingredient);
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.updateIngredient(
                  id: ingredientId,
                  ingredient: updatedIngredient,
                );

                expect(Isar.getInstance(), isNull);
              },
            );

            test(
              'Should update ingredient',
              () async {
                await datasource.updateIngredient(
                  id: ingredientId,
                  ingredient: updatedIngredient,
                );

                final isar = await Isar.open(
                  [IngredientSchema],
                  directory: databasePath,
                );

                final updatedIngredientFromDatabase =
                    await isar.ingredients.get(ingredientId);

                await isar.close();

                expect(
                  updatedIngredientFromDatabase,
                  Ingredient(
                    id: ingredientId,
                    name: updatedIngredient.name,
                    description: updatedIngredient.description,
                  ),
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
        late Id addedIngredientId;

        setUp(() async {
          addedIngredientId = await datasource.addIngredient(ingredient);
        });

        group(
          'Succeed',
          () {
            test(
              'Should Isar instance is closed',
              () async {
                await datasource.deleteIngredient(addedIngredientId);

                expect(Isar.getInstance(), isNull);
              },
            );
          },
        );
      },
    );
  });
}
