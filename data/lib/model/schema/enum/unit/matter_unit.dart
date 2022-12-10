import 'package:domain/domain.dart';

enum MatterUnit {
  milligram,
  gram,
  kilogram,
  ounce,
  pound,
  cubicCentimeter,
  milliliter,
  liter,
  teaspoon,
  tablespoon,
  fluidOunce,
  cup,
  count;

  static MatterUnit fromAmount(Amount amount) {
    if (amount is Milligram) return milligram;
    if (amount is Gram) return gram;
    if (amount is Kilogram) return kilogram;
    if (amount is Ounce) return ounce;
    if (amount is Pound) return pound;
    if (amount is CubicCentimeter) return cubicCentimeter;
    if (amount is Milliliter) return milliliter;
    if (amount is Liter) return liter;
    if (amount is Teaspoon) return teaspoon;
    if (amount is Tablespoon) return tablespoon;
    if (amount is FluidOunce) return fluidOunce;
    if (amount is Cup) return cup;
    if (amount is Count) return count;
    throw ArgumentError.value(
      amount,
      'amount',
      'Unsupported type ${amount.runtimeType}',
    );
  }

  bool get isMilligram => this == milligram;
  bool get isGram => this == gram;
  bool get isKilogram => this == kilogram;
  bool get isOunce => this == ounce;
  bool get isPound => this == pound;
  bool get isCubicCentimeter => this == cubicCentimeter;
  bool get isMilliliter => this == milliliter;
  bool get isLiter => this == liter;
  bool get isTeaspoon => this == teaspoon;
  bool get isTablespoon => this == tablespoon;
  bool get isFluidOunce => this == fluidOunce;
  bool get isCup => this == cup;
  bool get isCount => this == count;

  Amount toAmount(double value) {
    if (isMilligram) return Milligram(value);
    if (isGram) return Gram(value);
    if (isKilogram) return Kilogram(value);
    if (isOunce) return Ounce(value);
    if (isPound) return Pound(value);
    if (isCubicCentimeter) return CubicCentimeter(value);
    if (isMilliliter) return Milliliter(value);
    if (isLiter) return Liter(value);
    if (isTeaspoon) return Teaspoon(value);
    if (isTablespoon) return Tablespoon(value);
    if (isFluidOunce) return FluidOunce(value);
    if (isCup) return Cup(value);
    if (isCount) return Count(value);
    throw StateError('Unsupported enum $this');
  }
}
