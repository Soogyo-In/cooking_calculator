part of 'volume.dart';

const literSymbol = 'L';

final class Liter extends Volume {
  Liter(double value)
      : _inMilliliters = (milliliterPerLiter * value).round(),
        super(
          symbol: literSymbol,
          value: value,
        );

  @override
  final int _inMilliliters;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter((milliliterPerLiter * value).round());

  @override
  Cup toCup() => Cup(cupPerLiter * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerLiter * value);

  @override
  Liter toLiter() => Liter(value);

  @override
  Milliliter toMilliliter() => Milliliter((milliliterPerLiter * value).round());

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerLiter * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerLiter * value);

  @override
  Liter roundedAt(int fractionDigits) => Liter(value.roundAt(fractionDigits));

  @override
  Liter operator +(Volume other) => Liter(value + other.toLiter().value);

  @override
  Liter operator -(Volume other) => Liter(value - other.toLiter().value);

  @override
  Liter operator *(num factor) => Liter(value * factor);

  @override
  Liter operator /(num divisor) => Liter(value / divisor);
}
