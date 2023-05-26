import 'package:data/data.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'IngredientAmountData can convert to',
    () {
      test(
        'Milligram if unit is milligram',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.milligram
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Milligram(0.0),
          );
        },
      );

      test(
        'Gram if unit is gram',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.gram
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Gram(0.0),
          );
        },
      );

      test(
        'Kilogram if unit is kilogram',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.kilogram
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Kilogram(0.0),
          );
        },
      );

      test(
        'Ounce if unit is ounce',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.ounce
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Ounce(0.0),
          );
        },
      );

      test(
        'Pound if unit is pound',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.pound
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Pound(0.0),
          );
        },
      );

      test(
        'CubicCentimeter if unit is cubicCentimeter',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.cubicCentimeter
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            CubicCentimeter(0.0),
          );
        },
      );

      test(
        'Milliliter if unit is milliliter',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.milliliter
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Milliliter(0.0),
          );
        },
      );

      test(
        'Liter if unit is liter',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.liter
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Liter(0.0),
          );
        },
      );

      test(
        'Teaspoon if unit is teaspoon',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.teaspoon
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Teaspoon(0.0),
          );
        },
      );

      test(
        'Tablespoon if unit is tablespoon',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.tablespoon
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Tablespoon(0.0),
          );
        },
      );

      test(
        'FluidOunce if unit is fluidOunce',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.fluidOunce
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            FluidOunce(0.0),
          );
        },
      );

      test(
        'Cup if unit is cup',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.cup
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Cup(0.0),
          );
        },
      );

      test(
        'Count if unit is count',
        () {
          final ingredientAmountData = PrepData()
            ..unit = MatterUnit.count
            ..value = 0.0;
          expect(
            ingredientAmountData.getAmount(),
            Count(0.0),
          );
        },
      );
    },
  );
}
