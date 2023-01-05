import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  test(
    'RecipeData can conver to IndexedRecipe',
    () {
      final countIngredient = IngredientAmountData()
        ..ingredientId = 1
        ..unit = MatterUnit.count
        ..value = 1.0;
      final massIngredient = IngredientAmountData()
        ..ingredientId = 2
        ..unit = MatterUnit.gram
        ..value = 1.0;
      final volumeIngredient = IngredientAmountData()
        ..ingredientId = 3
        ..unit = MatterUnit.liter
        ..value = 1.0;
      final temperatureData = TemperatureData()
        ..unit = TemperatureUnit.celsius
        ..value = 0.0;
      final directionData = DirectionData()
        ..description = 'description'
        ..ingredients = [
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
        IndexedRecipe(
          id: 1,
          name: 'name',
          directions: [
            Direction(
              description: 'description',
              countByIngredientId: {1: Count(1.0)},
              massByIngredientId: {2: Gram(1.0)},
              volumeByIngredientId: {3: Liter(1.0)},
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
