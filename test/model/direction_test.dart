import 'package:cooking_calulator/model/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final direction = Direction(
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
  );

  test(
    'Direction provides masses of each ingredients with ratio',
    () {
      expect(
        direction.getMassByIngredientWithRatio(0.5),
        {
          const Ingredient(name: 'mass 1'): const Mass.gram(100.0),
          const Ingredient(name: 'mass 2'): const Mass.ounce(1.0),
        },
      );
      expect(
        direction.getMassByIngredientWithRatio(2.0),
        {
          const Ingredient(name: 'mass 1'): const Mass.gram(400.0),
          const Ingredient(name: 'mass 2'): const Mass.ounce(4.0),
        },
      );
    },
  );

  test(
    'Direction provides volumes of each ingredients with ratio',
    () {
      expect(
        direction.getVolumeByIngredientWithRatio(0.5),
        {
          const Ingredient(name: 'volume 1'): const Volume.liter(100.0),
          const Ingredient(name: 'volume 2'): const Volume.teaspoon(1.0),
        },
      );
      expect(
        direction.getVolumeByIngredientWithRatio(2.0),
        {
          const Ingredient(name: 'volume 1'): const Volume.liter(400.0),
          const Ingredient(name: 'volume 2'): const Volume.teaspoon(4.0),
        },
      );
    },
  );

  test(
    'Direction provides counts of each ingredients with ratio',
    () {
      expect(
        direction.getCountByIngredientWithRatio(0.5),
        {
          const Ingredient(name: 'count 1'): const Count(0.5),
          const Ingredient(name: 'count 2'): const Count(1.0),
        },
      );
      expect(
        direction.getCountByIngredientWithRatio(2.0),
        {
          const Ingredient(name: 'count 1'): const Count(2.0),
          const Ingredient(name: 'count 2'): const Count(4.0),
        },
      );
    },
  );
}
