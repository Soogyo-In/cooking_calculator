import 'package:data/data.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test(
    'Check the unit is milligram should return true only the MatterUnit is milligram',
    () {
      final unit = MatterUnit.milligram;

      expect(unit.isMilligram, isTrue);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is gram should return true only the MatterUnit is gram',
    () {
      final unit = MatterUnit.gram;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isTrue);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is kilogram should return true only the MatterUnit is kilogram',
    () {
      final unit = MatterUnit.kilogram;
      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isTrue);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is ounce should return true only the MatterUnit is ounce',
    () {
      final unit = MatterUnit.ounce;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isTrue);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is pound should return true only the MatterUnit is pound',
    () {
      final unit = MatterUnit.pound;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isTrue);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is cubicCentimeter should return true only the MatterUnit is cubicCentimeter',
    () {
      final unit = MatterUnit.cubicCentimeter;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isTrue);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is milliliter should return true only the MatterUnit is milliliter',
    () {
      final unit = MatterUnit.milliliter;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isTrue);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is liter should return true only the MatterUnit is liter',
    () {
      final unit = MatterUnit.liter;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isTrue);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is teaspoon should return true only the MatterUnit is teaspoon',
    () {
      final unit = MatterUnit.teaspoon;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isTrue);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is tablespoon should return true only the MatterUnit is tablespoon',
    () {
      final unit = MatterUnit.tablespoon;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isTrue);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is fluidOunce should return true only the MatterUnit is fluidOunce',
    () {
      final unit = MatterUnit.fluidOunce;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isTrue);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is cup should return true only the MatterUnit is cup',
    () {
      final unit = MatterUnit.cup;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isTrue);
      expect(unit.isCount, isFalse);
    },
  );

  test(
    'Check the unit is count should return true only the MatterUnit is count',
    () {
      final unit = MatterUnit.count;

      expect(unit.isMilligram, isFalse);
      expect(unit.isGram, isFalse);
      expect(unit.isKilogram, isFalse);
      expect(unit.isOunce, isFalse);
      expect(unit.isPound, isFalse);
      expect(unit.isCubicCentimeter, isFalse);
      expect(unit.isMilliliter, isFalse);
      expect(unit.isLiter, isFalse);
      expect(unit.isTeaspoon, isFalse);
      expect(unit.isTablespoon, isFalse);
      expect(unit.isFluidOunce, isFalse);
      expect(unit.isCup, isFalse);
      expect(unit.isCount, isTrue);
    },
  );
}
