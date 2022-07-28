part of 'volume.dart';

@freezed
class Cup with _$Cup implements Volume {
  static const symbol = 'cp';

  const Cup._();

  const factory Cup(double value) = _Cup;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerCup * value);

  @override
  Cup toCup() => Cup(value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerCup * value);

  @override
  Liter toLiter() => Liter(literPerCup * value);

  @override
  Milliliter toMilliliter() => Milliliter(milliliterPerCup * value);

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerCup * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerCup * value);

  @override
  Cup operator +(Volume other) => Cup(value + other.toCup().value);

  @override
  Cup operator -(Volume other) => Cup(value - other.toCup().value);

  @override
  Cup operator *(num factors) => Cup(value * factors.toDouble());

  @override
  Cup operator /(num divisor) => Cup(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
