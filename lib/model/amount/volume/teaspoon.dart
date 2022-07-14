part of 'volume.dart';

@freezed
class Teaspoon with _$Teaspoon implements Volume {
  static const abbreviation = 'tsp';

  const Teaspoon._();

  const factory Teaspoon(double value) = _Teaspoon;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerTeaspoon * value);

  @override
  Cup toCup() => Cup(cupPerTeaspoon * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerTeaspoon * value);

  @override
  Liter toLiter() => Liter(literPerTeaspoon * value);

  @override
  Milliliter toMilliliter() => Milliliter(milliliterPerTeaspoon * value);

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerTeaspoon * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(value);

  @override
  Teaspoon operator +(Volume other) =>
      Teaspoon(value + other.toTeaspoon().value);

  @override
  Teaspoon operator -(Volume other) =>
      Teaspoon(value - other.toTeaspoon().value);

  @override
  Teaspoon operator *(num factors) => Teaspoon(value * factors.toDouble());

  @override
  Teaspoon operator /(num divisor) => Teaspoon(value / divisor);

  @override
  String toString() => '$value $abbreviation';
}
