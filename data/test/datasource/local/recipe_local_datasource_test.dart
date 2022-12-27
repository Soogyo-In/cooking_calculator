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

  group('Recipe', () {
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

    group('Add', () {
      group('Succeed', () {
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
            final persistentRecipe = await datasource.addRecipe(recipe);

            expect(
              persistentRecipe,
              Recipe(
                name: recipe.name,
                directions: recipe.directions,
                description: recipe.description,
                id: persistentRecipe.id,
                servings: recipe.servings,
              ),
            );
          },
        );
      });
    });

    test('Isar should be closed after adding the recipe', () {});

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
  });

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
