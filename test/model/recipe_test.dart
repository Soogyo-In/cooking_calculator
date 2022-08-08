import 'package:cooking_calulator/model/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Recipe<Mass> recipe;

  setUp(() {
    recipe = Recipe(
      name: 'recipe',
      servings: 4,
      directions: [
        Direction(
          description: 'step 1',
          amountByIngredient: {
            const Ingredient(name: 'ingredient 1'): const Mass.gram(200.0),
            const Ingredient(name: 'ingredient 2'): const Mass.ounce(2.0),
          },
          time: const Duration(minutes: 1),
        ),
        Direction(
          description: 'step 2',
          amountByIngredient: {
            const Ingredient(name: 'ingredient 1'): const Mass.milligram(200.0),
          },
          time: const Duration(days: 1),
        ),
        const Direction(
          description: 'step 3',
          time: Duration(minutes: 25),
          temperature: Temperature.celsius(170.0),
        ),
      ],
    );
  });

  test(
    'Recipe provides whole amounts of each ingredients',
    () {
      expect(
        recipe.amountByIngredient,
        {
          const Ingredient(name: 'ingredient 1'): const Mass.gram(200.2),
          const Ingredient(name: 'ingredient 2'): const Mass.ounce(2.0),
        },
      );
    },
  );

  test(
    'Recipe provides cooking time',
    () {
      expect(
        recipe.time,
        const Duration(days: 1, minutes: 26),
      );
    },
  );

  test(
    'Recipe provides amounts of each ingredients for servings',
    () {
      expect(
        recipe.getAmountByIngredientServingsFor(1),
        {
          const Ingredient(name: 'ingredient 1'): const Mass.gram(50.05),
          const Ingredient(name: 'ingredient 2'): const Mass.ounce(0.5),
        },
      );
      expect(
        recipe.getAmountByIngredientServingsFor(8),
        {
          const Ingredient(name: 'ingredient 1'): const Mass.gram(400.4),
          const Ingredient(name: 'ingredient 2'): const Mass.ounce(4.0),
        },
      );
    },
  );
}
