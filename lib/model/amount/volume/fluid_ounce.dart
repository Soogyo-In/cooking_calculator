part of 'volume.dart';

@freezed
class FluidOunce with _$FluidOunce implements Volume {
  static const abbreviation = 'fl.oz';

  const FluidOunce._();

  const factory FluidOunce(double value) = _FluidOunce;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerFluidOunce * value);

  @override
  Cup toCup() => Cup(cupPerFluidOunce * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(value);

  @override
  Liter toLiter() => Liter(literPerFluidOunce * value);

  @override
  Milliliter toMilliliter() => Milliliter(milliliterPerFluidOunce * value);

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerFluidOunce * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerFluidOunce * value);

  @override
  FluidOunce operator +(Volume other) =>
      FluidOunce(value + other.toFluidOunce().value);

  @override
  FluidOunce operator -(Volume other) =>
      FluidOunce(value - other.toFluidOunce().value);

  @override
  FluidOunce operator *(num factors) => FluidOunce(value * factors.toDouble());

  @override
  FluidOunce operator /(num divisor) => FluidOunce(value / divisor);

  @override
  String toString() => '$value $abbreviation';
}
