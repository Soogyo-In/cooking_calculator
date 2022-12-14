import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  final direction = Direction(
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
  );

  test(
    'Direction provides masses of each ingredients with ratio',
    () {
      expect(
        direction.getMassByIngredientWithRatio(0.5),
        {
          1: const Mass.gram(100.0),
          2: const Mass.ounce(1.0),
        },
      );
      expect(
        direction.getMassByIngredientWithRatio(2.0),
        {
          1: const Mass.gram(400.0),
          2: const Mass.ounce(4.0),
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
          3: const Volume.liter(100.0),
          4: const Volume.teaspoon(1.0),
        },
      );
      expect(
        direction.getVolumeByIngredientWithRatio(2.0),
        {
          3: const Volume.liter(400.0),
          4: const Volume.teaspoon(4.0),
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
          5: const Count(0.5),
          6: const Count(1.0),
        },
      );
      expect(
        direction.getCountByIngredientWithRatio(2.0),
        {
          5: const Count(2.0),
          6: const Count(4.0),
        },
      );
    },
  );
}
