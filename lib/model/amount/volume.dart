part of 'amount.dart';

const milliliterPerLiter = 1000.0;
const milliliterPerTeaspoon = 4.92892159375;
const milliliterPerTablespoon = 14.78676478125;
const milliliterPerFluidOunce = 29.5735295625;
const milliliterPerCup = 236.5882365;

const cubicCentimeterPerMilliliter = 1.0;
const literPerMilliliter = 1.0 / milliliterPerLiter;
const teaspoonPerMilliliter = 1.0 / milliliterPerTeaspoon;
const tablespoonPerMilliliter = 1.0 / milliliterPerTablespoon;
const fluidOuncePerMilliliter = 1.0 / milliliterPerFluidOunce;
const cupPerMilliliter = 1.0 / milliliterPerCup;

const milliliterPerCubicCentimeter = 1.0;
const literPerCubicCentimeter =
    literPerMilliliter * milliliterPerCubicCentimeter;
const teaspoonPerCubicCentimeter =
    teaspoonPerMilliliter * milliliterPerCubicCentimeter;
const tablespoonPerCubicCentimeter =
    tablespoonPerMilliliter * milliliterPerCubicCentimeter;
const fluidOuncePerCubicCentimeter =
    fluidOuncePerMilliliter * milliliterPerCubicCentimeter;
const cupPerCubicCentimeter = cupPerMilliliter * milliliterPerCubicCentimeter;

const cubicCentimeterPerLiter =
    cubicCentimeterPerMilliliter * milliliterPerLiter;
const teaspoonPerLiter = teaspoonPerMilliliter * milliliterPerLiter;
const tablespoonPerLiter = tablespoonPerMilliliter * milliliterPerLiter;
const fluidOuncePerLiter = fluidOuncePerMilliliter * milliliterPerLiter;
const cupPerLiter = cupPerMilliliter * milliliterPerLiter;

const cubicCentimeterPerTeaspoon =
    cubicCentimeterPerMilliliter * milliliterPerTeaspoon;
const literPerTeaspoon = literPerMilliliter * milliliterPerTeaspoon;
const tablespoonPerTeaspoon = tablespoonPerMilliliter * milliliterPerTeaspoon;
const fluidOuncePerTeaspoon = fluidOuncePerMilliliter * milliliterPerTeaspoon;
const cupPerTeaspoon = cupPerMilliliter * milliliterPerTeaspoon;

const cubicCentimeterPerTablespoon =
    cubicCentimeterPerMilliliter * milliliterPerTablespoon;
const literPerTablespoon = literPerMilliliter * milliliterPerTablespoon;
const teaspoonPerTablespoon = teaspoonPerMilliliter * milliliterPerTablespoon;
const fluidOuncePerTablespoon =
    fluidOuncePerMilliliter * milliliterPerTablespoon;
const cupPerTablespoon = cupPerMilliliter * milliliterPerTablespoon;

const cubicCentimeterPerFluidOunce =
    cubicCentimeterPerMilliliter * milliliterPerFluidOunce;
const literPerFluidOunce = literPerMilliliter * milliliterPerFluidOunce;
const teaspoonPerFluidOunce = teaspoonPerMilliliter * milliliterPerFluidOunce;
const tablespoonPerFluidOunce =
    tablespoonPerMilliliter * milliliterPerFluidOunce;
const cupPerFluidOunce = cupPerMilliliter * milliliterPerFluidOunce;

const cubicCentimeterPerCup = cubicCentimeterPerMilliliter * milliliterPerCup;
const literPerCup = literPerMilliliter * milliliterPerCup;
const teaspoonPerCup = teaspoonPerMilliliter * milliliterPerCup;
const tablespoonPerCup = tablespoonPerMilliliter * milliliterPerCup;
const fluidOuncePerCup = fluidOuncePerMilliliter * milliliterPerCup;

abstract class Volume implements Amount {
  factory Volume.cubicCentimeter(double value) = CubicCentimeter;

  factory Volume.milliliter(double value) = Milliliter;

  factory Volume.liter(double value) = Liter;

  factory Volume.teaspoon(double value) = Teaspoon;

  factory Volume.tablespoon(double value) = Tablespoon;

  factory Volume.fluidOunce(double value) = FluidOunce;

  factory Volume.cup(double value) = Cup;

  String get abbreviation;

  CubicCentimeter toCubicCentimeter();

  Milliliter toMilliliter();

  Liter toLiter();

  Teaspoon toTeaspoon();

  Tablespoon toTablespoon();

  FluidOunce toFluidOunce();

  Cup toCup();
}

@freezed
class CubicCentimeter with _$CubicCentimeter implements Volume {
  static const abbr = 'cc';

  const CubicCentimeter._();

  const factory CubicCentimeter.__(double value, String abbreviation) =
      _CubicCentimeter;

  factory CubicCentimeter(double value) => CubicCentimeter.__(value, abbr);

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
}

@freezed
class Milliliter with _$Milliliter implements Volume {
  static const abbr = 'mL';

  const Milliliter._();

  const factory Milliliter.__(double value, String abbreviation) = _Milliliter;

  factory Milliliter(double value) => Milliliter.__(value, abbr);

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
}

@freezed
class Liter with _$Liter implements Volume {
  static const abbr = 'L';

  const Liter._();

  const factory Liter.__(double value, String abbreviation) = _Liter;

  factory Liter(double value) => Liter.__(value, abbr);

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
}

@freezed
class Teaspoon with _$Teaspoon implements Volume {
  static const abbr = 'tsp';

  const Teaspoon._();

  const factory Teaspoon.__(double value, String abbreviation) = _Teaspoon;

  factory Teaspoon(double value) => Teaspoon.__(value, abbr);

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
}

@freezed
class Tablespoon with _$Tablespoon implements Volume {
  static const abbr = 'Tbsp';

  const Tablespoon._();

  const factory Tablespoon.__(double value, String abbreviation) = _Tablespoon;

  factory Tablespoon(double value) => Tablespoon.__(value, abbr);

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
}

@freezed
class FluidOunce with _$FluidOunce implements Volume {
  static const abbr = 'fl.oz';

  const FluidOunce._();

  const factory FluidOunce.__(double value, String abbreviation) = _FluidOunce;

  factory FluidOunce(double value) => FluidOunce.__(value, abbr);

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
}

@freezed
class Cup with _$Cup implements Volume {
  static const abbr = 'cp';

  const Cup._();

  const factory Cup.__(double value, String abbreviation) = _Cup;

  factory Cup(double value) => Cup.__(value, abbr);

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
}
