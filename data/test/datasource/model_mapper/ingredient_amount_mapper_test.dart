import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'IngredientAmountData can convert to',
    () {
      test(
        'Milligram if unit is milligram',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.milligram
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Milligram(0.0),
          );
        },
      );

      test(
        'Gram if unit is gram',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.gram
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Gram(0.0),
          );
        },
      );

      test(
        'Kilogram if unit is kilogram',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.kilogram
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Kilogram(0.0),
          );
        },
      );

      test(
        'Ounce if unit is ounce',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.ounce
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Ounce(0.0),
          );
        },
      );

      test(
        'Pound if unit is pound',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.pound
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Pound(0.0),
          );
        },
      );

      test(
        'CubicCentimeter if unit is cubicCentimeter',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.cubicCentimeter
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            CubicCentimeter(0.0),
          );
        },
      );

      test(
        'Milliliter if unit is milliliter',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.milliliter
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Milliliter(0.0),
          );
        },
      );

      test(
        'Liter if unit is liter',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.liter
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Liter(0.0),
          );
        },
      );

      test(
        'Teaspoon if unit is teaspoon',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.teaspoon
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Teaspoon(0.0),
          );
        },
      );

      test(
        'Tablespoon if unit is tablespoon',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.tablespoon
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Tablespoon(0.0),
          );
        },
      );

      test(
        'FluidOunce if unit is fluidOunce',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.fluidOunce
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            FluidOunce(0.0),
          );
        },
      );

      test(
        'Cup if unit is cup',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.cup
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Cup(0.0),
          );
        },
      );

      test(
        'Count if unit is count',
        () {
          final ingredientAmountData = IngredientAmountData()
            ..unit = MatterUnit.count
            ..value = 0.0;
          expect(
            ingredientAmountData.toAmount(),
            Count(0.0),
          );
        },
      );
    },
  );
}
