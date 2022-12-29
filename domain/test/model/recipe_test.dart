import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  late Recipe recipe;

  setUp(() {
    recipe = Recipe(
      name: 'recipe',
      servings: 4,
      directions: [
        Direction(
          description: 'step 1',
          massByIngredientId: {
            1: const Mass.gram(200.0),
            2: const Mass.ounce(2.0),
          },
          volumeByIngredientId: {
            3: const Volume.liter(200.0),
            4: const Volume.teaspoon(2.0),
          },
          countByIngredientId: {
            5: const Count(1.0),
            6: const Count(2.0),
          },
          time: const Duration(minutes: 1),
        ),
        Direction(
          description: 'step 2',
          massByIngredientId: {
            1: const Mass.milligram(200.0),
          },
          volumeByIngredientId: {
            3: const Volume.milliliter(200.0),
          },
          countByIngredientId: {
            5: const Count(1.0),
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
        recipe.massByIngredientId,
        {
          1: const Mass.gram(200.2),
          2: const Mass.ounce(2.0),
        },
      );
    },
  );

  test(
    'Recipe provides whole volumes of each ingredients',
    () {
      expect(
        recipe.volumeByIngredientId,
        {
          3: const Volume.liter(200.2),
          4: const Volume.teaspoon(2.0),
        },
      );
    },
  );

  test(
    'Recipe provides whole counts of each ingredients',
    () {
      expect(
        recipe.countByIngredientId,
        {
          5: const Count(2.0),
          6: const Count(2.0),
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
          1: const Mass.gram(100.1),
          2: const Mass.ounce(1.0),
        },
      );
      expect(
        recipe.getMassByIngredientWithRatio(2.0),
        {
          1: const Mass.gram(400.4),
          2: const Mass.ounce(4.0),
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
          3: const Volume.liter(100.1),
          4: const Volume.teaspoon(1.0),
        },
      );
      expect(
        recipe.getVolumeByIngredientWithRatio(2.0),
        {
          3: const Volume.liter(400.4),
          4: const Volume.teaspoon(4.0),
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
          5: const Count(1.0),
          6: const Count(1.0),
        },
      );
      expect(
        recipe.getCountByIngredientWithRatio(2.0),
        {
          5: const Count(4.0),
          6: const Count(4.0),
        },
      );
    },
  );
}
