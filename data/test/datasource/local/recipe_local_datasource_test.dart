import 'package:data/datasource/datasource.dart';
import 'package:data/exceptions.dart';
import 'package:data/model/model.dart';
import 'package:domain/domain.dart' as domain;
import 'package:domain/model/extension/extension.dart';
import 'package:isar/isar.dart';
import 'package:ktc_dart/ktc_dart.dart';
import 'package:test/test.dart';

part 'resources.dart';

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
        cookingTemperature: domain.Temperature.celsius(1.0),
        cookingTime: Duration(hours: 1),
        preps: [
          domain.Prep(
            ingredient: domain.StoredIngredient(id: 1, name: '1'),
            amount: domain.Count(1.0),
          ),
          domain.Prep(
            ingredient: domain.StoredIngredient(id: 2, name: '2'),
            amount: domain.Gram(1.0),
          ),
          domain.Prep(
            ingredient: domain.StoredIngredient(id: 3, name: '3'),
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
            cookingTemperature:
                domainDirection.cookingTemperature?.toDataModel(),
            cookingTimeInSeconds: domainDirection.cookingTime.inSeconds,
          ),
        ],
        name: domainRecipe.name,
        servings: domainRecipe.servings,
      );

      Future<Id> addRecipe() async {
        final isar = await Isar.open(
          [RecipeSchema, IngredientSchema],
          directory: databasePath,
        );
        final storedRecipeId = isar.writeTxn(
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
            return isar.recipes.put(dataRecipe);
          },
        );

        await isar.close();

        return storedRecipeId;
      }

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
                'Should return added recipe object with id',
                () async {
                  final storedRecipe = await datasource.addRecipe(domainRecipe);
                  final isar = await Isar.open(
                    [RecipeSchema],
                    directory: databasePath,
                  );

                  await isar.close();

                  expect(storedRecipe, domainRecipe.withId(1));
                },
              );
            },
          );
        },
      );

      group(
        'Read',
        () {
          late Id storedRecipeId;

          setUp(() async {
            storedRecipeId = await addRecipe();
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.getRecipe(storedRecipeId);

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return read recipe object',
                () async {
                  expect(
                    await datasource.getRecipe(storedRecipeId),
                    domain.StoredRecipe(
                      id: storedRecipeId,
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
          setUp(() async {
            await addRecipe();
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
                    [domainRecipe.withId(1)],
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
          late Id storedRecipeId;
          final updatedDirection = domain.Direction(
            description: 'newDescription',
            cookingTemperature: domain.Temperature.celsius(2.0),
            cookingTime: Duration(hours: 2),
            preps: [
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

          setUp(() async {
            final storedRecipe = await datasource.addRecipe(domainRecipe);
            storedRecipeId = storedRecipe.id;
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.updateRecipe(
                    id: storedRecipeId,
                    recipe: updatedRecipe,
                  );

                  expect(Isar.getInstance(), isNull);
                },
              );

              test(
                'Should return updated recipe object',
                () async {
                  final updatedRecipeFromDataBase =
                      await datasource.updateRecipe(
                    id: storedRecipeId,
                    recipe: updatedRecipe,
                  );

                  expect(
                    updatedRecipeFromDataBase,
                    updatedRecipe.withId(storedRecipeId),
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
          late Id storedRecipeId;

          setUp(() async {
            storedRecipeId = await addRecipe();
          });

          group(
            'Succeed',
            () {
              test(
                'Should Isar instance is closed',
                () async {
                  await datasource.deleteRecipe(storedRecipeId);

                  expect(Isar.getInstance(), isNull);
                },
              );
            },
          );
        },
      );

      group(
        '검색',
        () {
          setUp(() async {
            final isar = await Isar.open(
              [RecipeSchema, IngredientSchema],
              directory: databasePath,
            );
            await isar.writeTxn(() async {
              await isar.ingredients.putAll(_ingredientSchemas);
              await isar.recipes.putAll(_recipeSchemas);
            });
            await isar.close();
          });

          tearDown(() async {
            final isar = await Isar.open(
              [RecipeSchema, IngredientSchema],
              directory: databasePath,
            );
            await isar.writeTxn(isar.clear);
            await isar.close();
          });

          test(
            '페이징',
            () async {
              expect(
                await datasource.searchRecipes(page: 1, size: 2),
                [_storedRecipes[2], _storedRecipes[3]],
              );
            },
          );

          test(
            '이름 검색',
            () async {
              expect(
                await datasource.searchRecipes(name: 'recipe'),
                _storedRecipes,
              );
              expect(
                await datasource.searchRecipes(name: 'recipe2'),
                [_storedRecipes[2], _storedRecipes[3]],
              );
              expect(
                await datasource.searchRecipes(name: 'recipe22'),
                [_storedRecipes[3]],
              );
            },
          );

          test(
            '재료 필터',
            () async {
              expect(
                await datasource.searchRecipes(ingredientIds: [1]),
                [_storedRecipes[0], _storedRecipes[1], _storedRecipes[2]],
              );
              expect(
                await datasource.searchRecipes(ingredientIds: [1, 3]),
                [_storedRecipes[2]],
              );
            },
          );

          test(
            '조리시간 필터',
            () async {
              expect(
                await datasource.searchRecipes(
                  cookingTime: Duration(hours: 3),
                ),
                _storedRecipes,
              );
              expect(
                await datasource.searchRecipes(
                  cookingTime: Duration(hours: 2),
                ),
                [_storedRecipes[1], _storedRecipes[2], _storedRecipes[3]],
              );
              expect(
                await datasource.searchRecipes(
                  cookingTime: Duration(hours: 1),
                ),
                [_storedRecipes[2], _storedRecipes[3]],
              );
            },
          );

          test(
            '이름으로 검색하여 재료, 요리시간으로 필터링 된 데이터를 페이징하여 제공한다.',
            () async {
              expect(
                await datasource.searchRecipes(
                  name: 'recipe',
                  cookingTime: Duration(hours: 2),
                  ingredientIds: [3],
                  size: 1,
                  page: 1,
                ),
                [_storedRecipes[3]],
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

    Future<Id> addIngredient() async {
      final isar = await Isar.open(
        [IngredientSchema],
        directory: databasePath,
      );

      final id = isar.writeTxn(
        () => isar.ingredients.put(Ingredient(
          name: ingredient.name,
          description: ingredient.description,
        )),
      );

      await isar.close();

      return id;
    }

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
                final addedIngredient = await datasource.addIngredient(
                  ingredient,
                );

                expect(
                  addedIngredient,
                  ingredient.withId(addedIngredient.id),
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
          addedIngredientId = await addIngredient();
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
                  ingredient.withId(addedIngredientId),
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
          addedIngredientId = await addIngredient();
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
                  [ingredient.withId(addedIngredientId)],
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
          ingredientId = await addIngredient();
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
                final updatedIngredientFromDatabase =
                    await datasource.updateIngredient(
                  id: ingredientId,
                  ingredient: updatedIngredient,
                );

                expect(
                  updatedIngredientFromDatabase,
                  updatedIngredient.withId(ingredientId),
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
          addedIngredientId = await addIngredient();
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
