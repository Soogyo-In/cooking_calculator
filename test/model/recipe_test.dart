import 'package:cooking_calulator/model/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Recipe recipe;

  setUp(() {
    recipe = Recipe(
      name: 'recipe',
      servings: 4,
      directions: [
        Direction(
          description: 'step 1',
          massByIngredient: {
            const Ingredient(name: 'mass 1'): const Mass.gram(200.0),
            const Ingredient(name: 'mass 2'): const Mass.ounce(2.0),
          },
          volumeByIngredient: {
            const Ingredient(name: 'volume 1'): const Volume.liter(200.0),
            const Ingredient(name: 'volume 2'): const Volume.teaspoon(2.0),
          },
          countByIngredient: {
            const Ingredient(name: 'count 1'): const Count(1.0),
            const Ingredient(name: 'count 2'): const Count(2.0),
          },
          time: const Duration(minutes: 1),
        ),
        Direction(
          description: 'step 2',
          massByIngredient: {
            const Ingredient(name: 'mass 1'): const Mass.milligram(200.0),
          },
          volumeByIngredient: {
            const Ingredient(name: 'volume 1'): const Volume.milliliter(200.0),
          },
          countByIngredient: {
            const Ingredient(name: 'count 1'): const Count(1.0),
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
    'Recipe provides whole masses of each ingredients',
    () {
      expect(
        recipe.massByIngredient,
        {
          const Ingredient(name: 'mass 1'): const Mass.gram(200.2),
          const Ingredient(name: 'mass 2'): const Mass.ounce(2.0),
        },
      );
    },
  );

  test(
    'Recipe provides whole volumes of each ingredients',
    () {
      expect(
        recipe.volumeByIngredient,
        {
          const Ingredient(name: 'volume 1'): const Volume.liter(200.2),
          const Ingredient(name: 'volume 2'): const Volume.teaspoon(2.0),
        },
      );
    },
  );

  test(
    'Recipe provides whole counts of each ingredients',
    () {
      expect(
        recipe.countByIngredient,
        {
          const Ingredient(name: 'count 1'): const Count(2.0),
          const Ingredient(name: 'count 2'): const Count(2.0),
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
    'Recipe provides masses of each ingredients with ratio',
    () {
      expect(
        recipe.getMassByIngredientWithRatio(0.5),
        {
          const Ingredient(name: 'mass 1'): const Mass.gram(100.1),
          const Ingredient(name: 'mass 2'): const Mass.ounce(1.0),
        },
      );
      expect(
        recipe.getMassByIngredientWithRatio(2.0),
        {
          const Ingredient(name: 'mass 1'): const Mass.gram(400.4),
          const Ingredient(name: 'mass 2'): const Mass.ounce(4.0),
        },
      );
    },
  );

  test(
    'Recipe provides volumes of each ingredients with ratio',
    () {
      expect(
        recipe.getVolumeByIngredientWithRatio(0.5),
        {
          const Ingredient(name: 'volume 1'): const Volume.liter(100.1),
          const Ingredient(name: 'volume 2'): const Volume.teaspoon(1.0),
        },
      );
      expect(
        recipe.getVolumeByIngredientWithRatio(2.0),
        {
          const Ingredient(name: 'volume 1'): const Volume.liter(400.4),
          const Ingredient(name: 'volume 2'): const Volume.teaspoon(4.0),
        },
      );
    },
  );

  test(
    'Recipe provides counts of each ingredients with ratio',
    () {
      expect(
        recipe.getCountByIngredientWithRatio(0.5),
        {
          const Ingredient(name: 'count 1'): const Count(1.0),
          const Ingredient(name: 'count 2'): const Count(1.0),
        },
      );
      expect(
        recipe.getCountByIngredientWithRatio(2.0),
        {
          const Ingredient(name: 'count 1'): const Count(4.0),
          const Ingredient(name: 'count 2'): const Count(4.0),
        },
      );
    },
  );
}
