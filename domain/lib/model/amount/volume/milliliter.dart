part of 'volume.dart';

const milliliterSymbol = 'mL';

final class Milliliter extends Volume {
  Milliliter(int value)
      : super(
          symbol: milliliterSymbol,
          value: value.toDouble(),
        );

  @override
  int get _inMilliliters => value.toInt();

  @override
  CubicCentimeter toCubicCentimeter() => CubicCentimeter(value.toInt());

  @override
  Cup toCup() => Cup(cupPerMilliliter * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerMilliliter * value);

  @override
  Liter toLiter() => Liter(literPerMilliliter * value);

  @override
  Milliliter toMilliliter() => Milliliter(value.toInt());

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerMilliliter * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerMilliliter * value);

  @override
  Milliliter roundedAt(int fractionDigits) => Milliliter(value.toInt());

  @override
  Milliliter operator +(Volume other) =>
      Milliliter((value + other.toMilliliter().value).round());

  @override
  Milliliter operator -(Volume other) =>
      Milliliter((value - other.toMilliliter().value).round());

  @override
  Milliliter operator *(num factor) => Milliliter((value * factor).round());

  @override
  Milliliter operator /(num divisor) => Milliliter((value / divisor).round());
}
