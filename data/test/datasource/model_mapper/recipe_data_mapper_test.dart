import 'package:data/data.dart';
import 'package:test/test.dart';

void main() {
  test(
    'RecipeData can conver to IndexedRecipe',
    () {
      final countIngredient = PrepData()
        ..ingredientId = 1
        ..unit = MatterUnit.count
        ..value = 1.0;
      final massIngredient = PrepData()
        ..ingredientId = 2
        ..unit = MatterUnit.gram
        ..value = 1.0;
      final volumeIngredient = PrepData()
        ..ingredientId = 3
        ..unit = MatterUnit.liter
        ..value = 1.0;
      final temperatureData = TemperatureData()
        ..unit = TemperatureUnit.celsius
        ..value = 0.0;
      final directionData = DirectionData()
        ..description = 'description'
        ..preps = [
          countIngredient,
          massIngredient,
          volumeIngredient,
        ]
        ..temperature = temperatureData
        ..timeInSeconds = 1;
      final recipeData = RecipeData(id: 1)
        ..description = 'description'
        ..directions = [directionData]
        ..name = 'name'
        ..servings = 1;

      expect(
        recipeData.toRecipe(),
        Recipe(
          id: 1,
          name: 'name',
          directions: [
            Direction(
              description: 'description',
              preps: [
                Prep(
                  ingredient: Ingredient(
                    id: 1,
                    name: '1',
                  ),
                  amount: Count(1.0),
                ),
                Prep(
                  ingredient: Ingredient(
                    id: 2,
                    name: '2',
                  ),
                  amount: Gram(1.0),
                ),
                Prep(
                  ingredient: Ingredient(
                    id: 3,
                    name: '3',
                  ),
                  amount: Liter(1.0),
                ),
              ],
              temperature: Temperature.celsius(0.0),
              time: Duration(seconds: 1),
            ),
          ],
          description: 'description',
          servings: 1,
        ),
      );
    },
  );
}
