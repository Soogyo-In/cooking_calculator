part of 'volume.dart';

@freezed
class Tablespoon with _$Tablespoon implements Volume {
  static const symbol = 'Tbsp';

  const Tablespoon._();

  const factory Tablespoon(double value) = _Tablespoon;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerTablespoon * value);

  @override
  Cup toCup() => Cup(cupPerTablespoon * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerTablespoon * value);

  @override
  Liter toLiter() => Liter(literPerTablespoon * value);

  @override
  Milliliter toMilliliter() => Milliliter(milliliterPerTablespoon * value);

  @override
  Tablespoon toTablespoon() => Tablespoon(value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerTablespoon * value);

  @override
  Tablespoon operator +(Volume other) =>
      Tablespoon(value + other.toTablespoon().value);

  @override
  Tablespoon operator -(Volume other) =>
      Tablespoon(value - other.toTablespoon().value);

  @override
  Tablespoon operator *(num factors) => Tablespoon(value * factors.toDouble());

  @override
  Tablespoon operator /(num divisor) => Tablespoon(value / divisor);

  @override
  String toZeroBoundedStringAsFixed(int fractionDigits) =>
      '${value.toZeroBoundedStringAsFixed(fractionDigits)} $symbol';
}
