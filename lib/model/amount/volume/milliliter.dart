part of 'volume.dart';

@freezed
class Milliliter with _$Milliliter implements Volume {
  static const abbreviation = 'mL';

  const Milliliter._();

  const factory Milliliter(double value) = _Milliliter;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerMilliliter * value);

  @override
  Cup toCup() => Cup(cupPerMilliliter * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerMilliliter * value);

  @override
  Liter toLiter() => Liter(literPerMilliliter * value);

  @override
  Milliliter toMilliliter() => Milliliter(value);

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerMilliliter * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerMilliliter * value);

  @override
  Milliliter operator +(Volume other) =>
      Milliliter(value + other.toMilliliter().value);

  @override
  Milliliter operator -(Volume other) =>
      Milliliter(value - other.toMilliliter().value);

  @override
  Milliliter operator *(num factors) => Milliliter(value * factors.toDouble());

  @override
  Milliliter operator /(num divisor) => Milliliter(value / divisor);

  @override
  String toString() => '$value $abbreviation';
}
