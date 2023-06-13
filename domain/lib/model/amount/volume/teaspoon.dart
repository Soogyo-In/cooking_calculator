part of 'volume.dart';

const teaspoonSymbol = 'tsp';

final class Teaspoon extends Volume {
  Teaspoon(double value)
      : _inMilliliters = (milliliterPerTeaspoon * value).round(),
        super(
          symbol: teaspoonSymbol,
          value: value,
        );

  @override
  final int _inMilliliters;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter((milliliterPerTeaspoon * value).round());

  @override
  Cup toCup() => Cup(cupPerTeaspoon * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerTeaspoon * value);

  @override
  Liter toLiter() => Liter(literPerTeaspoon * value);

  @override
  Milliliter toMilliliter() =>
      Milliliter((milliliterPerTeaspoon * value).round());

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerTeaspoon * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(value);

  @override
  Teaspoon roundedAt(int fractionDigits) =>
      Teaspoon(value.roundAt(fractionDigits));

  @override
  Teaspoon operator +(Volume other) =>
      Teaspoon(value + other.toTeaspoon().value);

  @override
  Teaspoon operator -(Volume other) =>
      Teaspoon(value - other.toTeaspoon().value);

  @override
  Teaspoon operator *(num factor) => Teaspoon(value * factor);

  @override
  Teaspoon operator /(num divisor) => Teaspoon(value / divisor);
}
