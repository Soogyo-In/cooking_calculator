import 'package:data/data.dart';
import 'package:domain/domain.dart';

extension IngredientAmountMapper on IngredientAmount {
  static MatterUnit fromAmount(Amount amount) {
    if (amount is Milligram) return MatterUnit.milligram;
    if (amount is Gram) return MatterUnit.gram;
    if (amount is Kilogram) return MatterUnit.kilogram;
    if (amount is Ounce) return MatterUnit.ounce;
    if (amount is Pound) return MatterUnit.pound;
    if (amount is CubicCentimeter) return MatterUnit.cubicCentimeter;
    if (amount is Milliliter) return MatterUnit.milliliter;
    if (amount is Liter) return MatterUnit.liter;
    if (amount is Teaspoon) return MatterUnit.teaspoon;
    if (amount is Tablespoon) return MatterUnit.tablespoon;
    if (amount is FluidOunce) return MatterUnit.fluidOunce;
    if (amount is Cup) return MatterUnit.cup;
    if (amount is Count) return MatterUnit.count;
    throw ArgumentError.value(
      amount,
      'amount',
      'Unsupported type ${amount.runtimeType}',
    );
  }

  Amount toAmount() {
    if (unit.isMilligram) return Milligram(value);
    if (unit.isGram) return Gram(value);
    if (unit.isKilogram) return Kilogram(value);
    if (unit.isOunce) return Ounce(value);
    if (unit.isPound) return Pound(value);
    if (unit.isCubicCentimeter) return CubicCentimeter(value);
    if (unit.isMilliliter) return Milliliter(value);
    if (unit.isLiter) return Liter(value);
    if (unit.isTeaspoon) return Teaspoon(value);
    if (unit.isTablespoon) return Tablespoon(value);
    if (unit.isFluidOunce) return FluidOunce(value);
    if (unit.isCup) return Cup(value);
    if (unit.isCount) return Count(value);
    throw StateError('Unsupported enum ${unit.runtimeType}');
  }
}
