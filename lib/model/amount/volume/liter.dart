part of 'volume.dart';

@freezed
class Liter with _$Liter implements Volume {
  static const abbreviation = 'L';

  const Liter._();

  const factory Liter(double value) = _Liter;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerLiter * value);

  @override
  Cup toCup() => Cup(cupPerLiter * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerLiter * value);

  @override
  Liter toLiter() => Liter(value);

  @override
  Milliliter toMilliliter() => Milliliter(milliliterPerLiter * value);

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerLiter * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerLiter * value);

  @override
  Liter operator +(Volume other) => Liter(value + other.toLiter().value);

  @override
  Liter operator -(Volume other) => Liter(value - other.toLiter().value);

  @override
  Liter operator *(num factors) => Liter(value * factors.toDouble());

  @override
  Liter operator /(num divisor) => Liter(value / divisor);

  @override
  String toString() => '$value $abbreviation';
}
