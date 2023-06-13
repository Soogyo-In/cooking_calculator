part of 'volume.dart';

const cupSymbol = 'cp';

final class Cup extends Volume {
  Cup(double value)
      : _inMilliliters = (milliliterPerCup * value).round(),
        super(
          symbol: cupSymbol,
          value: value,
        );

  @override
  final int _inMilliliters;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter((milliliterPerCup * value).round());

  @override
  Cup toCup() => Cup(value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerCup * value);

  @override
  Liter toLiter() => Liter(literPerCup * value);

  @override
  Milliliter toMilliliter() => Milliliter((milliliterPerCup * value).round());

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerCup * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerCup * value);

  @override
  Cup roundedAt(int fractionDigits) => Cup(value.roundAt(fractionDigits));

  @override
  Cup operator +(Volume other) => Cup(value + other.toCup().value);

  @override
  Cup operator -(Volume other) => Cup(value - other.toCup().value);

  @override
  Cup operator *(num factor) => Cup(value * factor);

  @override
  Cup operator /(num divisor) => Cup(value / divisor);
}
