part of 'volume.dart';

const cubicCentimeterSymbol = 'cc';

final class CubicCentimeter extends Volume {
  CubicCentimeter(int value)
      : super(
          symbol: cubicCentimeterSymbol,
          value: value.toDouble(),
        );

  @override
  int get _inMilliliters => value.toInt();

  @override
  CubicCentimeter toCubicCentimeter() => CubicCentimeter(value.toInt());

  @override
  Cup toCup() => Cup(value * cupPerCubicCentimeter);

  @override
  FluidOunce toFluidOunce() => FluidOunce(value * fluidOuncePerCubicCentimeter);

  @override
  Liter toLiter() => Liter(value * literPerCubicCentimeter);

  @override
  Milliliter toMilliliter() =>
      Milliliter((value * milliliterPerCubicCentimeter).toInt());

  @override
  Tablespoon toTablespoon() => Tablespoon(value * tablespoonPerCubicCentimeter);

  @override
  Teaspoon toTeaspoon() => Teaspoon(value * teaspoonPerCubicCentimeter);

  @override
  CubicCentimeter roundedAt(int fractionDigits) =>
      CubicCentimeter(value.toInt());

  @override
  CubicCentimeter operator +(Volume other) =>
      CubicCentimeter((value + other.toCubicCentimeter().value).round());

  @override
  CubicCentimeter operator -(Volume other) =>
      CubicCentimeter((value - other.toCubicCentimeter().value).round());

  @override
  CubicCentimeter operator *(num factor) =>
      CubicCentimeter((value * factor).round());

  @override
  CubicCentimeter operator /(num divisor) =>
      CubicCentimeter((value / divisor).round());

  @override
  CubicCentimeter copyWith({covariant int? value}) =>
      CubicCentimeter(value ?? this.value.toInt());
}
