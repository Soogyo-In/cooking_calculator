part of 'volume.dart';

@freezed
class CubicCentimeter with _$CubicCentimeter implements Volume {
  static const symbol = 'cc';

  const CubicCentimeter._();

  const factory CubicCentimeter(double value) = _CubicCentimeter;

  @override
  CubicCentimeter toCubicCentimeter() => CubicCentimeter(value);

  @override
  Cup toCup() => Cup(value * cupPerCubicCentimeter);

  @override
  FluidOunce toFluidOunce() => FluidOunce(value * fluidOuncePerCubicCentimeter);

  @override
  Liter toLiter() => Liter(value * literPerCubicCentimeter);

  @override
  Milliliter toMilliliter() => Milliliter(value * milliliterPerCubicCentimeter);

  @override
  Tablespoon toTablespoon() => Tablespoon(value * tablespoonPerCubicCentimeter);

  @override
  Teaspoon toTeaspoon() => Teaspoon(value * teaspoonPerCubicCentimeter);

  @override
  CubicCentimeter operator +(Volume other) =>
      CubicCentimeter(value + other.toCubicCentimeter().value);

  @override
  CubicCentimeter operator -(Volume other) =>
      CubicCentimeter(value - other.toCubicCentimeter().value);

  @override
  CubicCentimeter operator *(num factors) =>
      CubicCentimeter(value * factors.toDouble());

  @override
  CubicCentimeter operator /(num divisor) => CubicCentimeter(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
