import 'package:data/model/model.dart';
import 'package:domain/domain.dart' as domain;
import 'package:test/test.dart';

void main() {
  group(
    'Data recipe',
    () {
      test(
        'should convert to domain prep',
        () {
          final prep = Prep(
            ingredientId: 1,
            unit: MatterUnit.count,
            value: 1,
          );
          final temperature = Temperature();
          final direction = Direction(
            description: 'description',
            preps: [prep],
            cookingTemperature: temperature,
            cookingTimeInSeconds: 0,
          );
          final recipe = Recipe(
            id: 1,
            servings: 1,
            name: 'name',
            description: 'description',
            directions: [direction],
          );
          final ingredient = Ingredient(
            id: 1,
            name: 'name',
            description: 'description',
          );

          expect(
            recipe.toDomainModel([ingredient]),
            domain.StoredRecipe(
              id: recipe.id,
              name: recipe.name,
              description: recipe.description,
              servings: recipe.servings,
              directions: [
                domain.Direction(
                  description: direction.description,
                  preps: [
                    domain.Prep(
                      amount: domain.Count(1),
                      ingredient: domain.StoredIngredient(
                        id: ingredient.id,
                        name: ingredient.name,
                        description: ingredient.description,
                      ),
                    ),
                  ],
                  cookingTemperature: domain.Celsius(temperature.value),
                  cookingTime:
                      Duration(seconds: direction.cookingTimeInSeconds),
                ),
              ],
            ),
          );
        },
      );
    },
  );

  group(
    'Domain recipe',
    () {
      test(
        'should convert to data prep',
        () {
          final ingredient = domain.StoredIngredient(
            id: 1,
            name: 'name',
            description: 'description',
          );
          final prep = domain.Prep(
            amount: domain.Count(1),
            ingredient: ingredient,
          );
          final direction = domain.Direction(
            description: 'description',
            cookingTemperature: domain.Celsius(0),
            cookingTime: Duration(seconds: 0),
            preps: [prep],
          );
          final recipe = domain.StoredRecipe(
            id: 1,
            description: 'description',
            name: 'name',
            servings: 1,
            directions: [direction],
          );

          expect(
            recipe.toDataModel(id: recipe.id, ingredientIds: [1]),
            Recipe(
              id: recipe.id,
              name: recipe.name,
              description: recipe.description,
              servings: recipe.servings,
              directions: [
                Direction(
                  description: direction.description,
                  cookingTemperature: Temperature(),
                  cookingTimeInSeconds: direction.cookingTime.inSeconds,
                  preps: [
                    Prep(
                      ingredientId: ingredient.id,
                      unit: MatterUnit.count,
                      value: 1,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
