import 'package:data/data.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';
import 'package:domain/domain.dart' as domain;

void main() async {
  late RecipeLocalDatasource datasource;

  setUp(() {
    Isar.initializeIsarCore(download: true);
    datasource = RecipeLocalDatasource();
  });

  group('[Recipe]', () {
    test(
      'should return added recipe object with id after adding the recipe',
      () {
        final recipe = domain.Recipe(
          directions: [
            domain.Direction(
              description: 'description',
              temperature: domain.Temperature.celsius(1.0),
              time: Duration(hours: 1),
              countByIngredientId: {
                domain.Ingredient(
                  name: 'egg',
                  description: 'description',
                ): domain.Count(1),
              },
              massByIngredientId: {
                domain.Ingredient(
                  name: 'salt',
                  description: 'description',
                ): domain.Gram(1),
              },
              volumeByIngredientId: {
                domain.Ingredient(
                  name: 'milk',
                  description: 'description',
                ): domain.Liter(1),
              },
            ),
          ],
          name: 'name',
          description: 'description',
          servings: 1,
        );
      },
    );

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
