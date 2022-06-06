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

  factory Volume.fromJson(Map<String, dynamic> json) {
    final abbreviation = json['abbreviation'];

    switch (abbreviation) {
      case CubicCentimeter.abbr:
        return CubicCentimeter.fromJson(json);
      case Cup.abbr:
        return Cup.fromJson(json);
      case FluidOunce.abbr:
        return FluidOunce.fromJson(json);
      case Liter.abbr:
        return Liter.fromJson(json);
      case Milliliter.abbr:
        return Milliliter.fromJson(json);
      case Tablespoon.abbr:
        return Tablespoon.fromJson(json);
      case Teaspoon.abbr:
        return Teaspoon.fromJson(json);
    }

    throw CheckedFromJsonException(
      json,
      'abbreviation',
      'Volume',
      'Unsupported volume unit: $abbreviation',
    );
  }

  Map<String, dynamic> toJson() {
    if (this is CubicCentimeter) return (this as CubicCentimeter).toJson();
    if (this is Cup) return (this as Cup).toJson();
    if (this is FluidOunce) return (this as FluidOunce).toJson();
    if (this is Liter) return (this as Liter).toJson();
    if (this is Milliliter) return (this as Milliliter).toJson();
    if (this is Tablespoon) return (this as Tablespoon).toJson();
    if (this is Teaspoon) return (this as Teaspoon).toJson();

    throw JsonUnsupportedObjectError(this);
  }

  String get abbreviation;

  Volume toCubicCentimeter();

  Volume toMilliliter();

  Volume toLiter();

  Volume toTeaspoon();

  Volume toTablespoon();

  Volume toFluidOunce();

  Volume toCup();
}

@freezed
class CubicCentimeter with _$CubicCentimeter implements Volume {
  static const abbr = 'cc';

  const CubicCentimeter._();

  const factory CubicCentimeter.__(double value, String abbreviation) =
      _CubicCentimeter;

  factory CubicCentimeter(double value) => CubicCentimeter.__(value, abbr);

  factory CubicCentimeter.fromJson(Map<String, dynamic> json) =>
      _$CubicCentimeterFromJson(json);

  @override
  Volume toCubicCentimeter() => CubicCentimeter(value);

  @override
  Volume toCup() => Cup(value * cupPerCubicCentimeter);

  @override
  Volume toFluidOunce() => FluidOunce(value * fluidOuncePerCubicCentimeter);

  @override
  Volume toLiter() => Liter(value * literPerCubicCentimeter);

  @override
  Volume toMilliliter() => Milliliter(value * milliliterPerCubicCentimeter);

  @override
  Volume toTablespoon() => Tablespoon(value * tablespoonPerCubicCentimeter);

  @override
  Volume toTeaspoon() => Teaspoon(value * teaspoonPerCubicCentimeter);
}

@freezed
class Milliliter with _$Milliliter implements Volume {
  static const abbr = 'mL';

  const Milliliter._();

  const factory Milliliter.__(double value, String abbreviation) = _Milliliter;

  factory Milliliter(double value) => Milliliter.__(value, abbr);

  factory Milliliter.fromJson(Map<String, dynamic> json) =>
      _$MilliliterFromJson(json);

  @override
  Volume toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerMilliliter * value);

  @override
  Volume toCup() => Cup(cupPerMilliliter * value);

  @override
  Volume toFluidOunce() => FluidOunce(fluidOuncePerMilliliter * value);

  @override
  Volume toLiter() => Liter(literPerMilliliter * value);

  @override
  Volume toMilliliter() => Milliliter(value);

  @override
  Volume toTablespoon() => Tablespoon(tablespoonPerMilliliter * value);

  @override
  Volume toTeaspoon() => Teaspoon(teaspoonPerMilliliter * value);
}

@freezed
class Liter with _$Liter implements Volume {
  static const abbr = 'L';

  const Liter._();

  const factory Liter.__(double value, String abbreviation) = _Liter;

  factory Liter(double value) => Liter.__(value, abbr);

  factory Liter.fromJson(Map<String, dynamic> json) => _$LiterFromJson(json);

  @override
  Volume toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerLiter * value);

  @override
  Volume toCup() => Cup(cupPerLiter * value);

  @override
  Volume toFluidOunce() => FluidOunce(fluidOuncePerLiter * value);

  @override
  Volume toLiter() => Liter(value);

  @override
  Volume toMilliliter() => Milliliter(milliliterPerLiter * value);

  @override
  Volume toTablespoon() => Tablespoon(tablespoonPerLiter * value);

  @override
  Volume toTeaspoon() => Teaspoon(teaspoonPerLiter * value);
}

@freezed
class Teaspoon with _$Teaspoon implements Volume {
  static const abbr = 'tsp';

  const Teaspoon._();

  const factory Teaspoon.__(double value, String abbreviation) = _Teaspoon;

  factory Teaspoon(double value) => Teaspoon.__(value, abbr);

  factory Teaspoon.fromJson(Map<String, dynamic> json) =>
      _$TeaspoonFromJson(json);

  @override
  Volume toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerTeaspoon * value);

  @override
  Volume toCup() => Cup(cupPerTeaspoon * value);

  @override
  Volume toFluidOunce() => FluidOunce(fluidOuncePerTeaspoon * value);

  @override
  Volume toLiter() => Liter(literPerTeaspoon * value);

  @override
  Volume toMilliliter() => Milliliter(milliliterPerTeaspoon * value);

  @override
  Volume toTablespoon() => Tablespoon(tablespoonPerTeaspoon * value);

  @override
  Volume toTeaspoon() => Teaspoon(value);
}

@freezed
class Tablespoon with _$Tablespoon implements Volume {
  static const abbr = 'Tbsp';

  const Tablespoon._();

  const factory Tablespoon.__(double value, String abbreviation) = _Tablespoon;

  factory Tablespoon(double value) => Tablespoon.__(value, abbr);

  factory Tablespoon.fromJson(Map<String, dynamic> json) =>
      _$TablespoonFromJson(json);

  @override
  Volume toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerTablespoon * value);

  @override
  Volume toCup() => Cup(cupPerTablespoon * value);

  @override
  Volume toFluidOunce() => FluidOunce(fluidOuncePerTablespoon * value);

  @override
  Volume toLiter() => Liter(literPerTablespoon * value);

  @override
  Volume toMilliliter() => Milliliter(milliliterPerTablespoon * value);

  @override
  Volume toTablespoon() => Tablespoon(value);

  @override
  Volume toTeaspoon() => Teaspoon(teaspoonPerTablespoon * value);
}

@freezed
class FluidOunce with _$FluidOunce implements Volume {
  static const abbr = 'fl.oz';

  const FluidOunce._();

  const factory FluidOunce.__(double value, String abbreviation) = _FluidOunce;

  factory FluidOunce(double value) => FluidOunce.__(value, abbr);

  factory FluidOunce.fromJson(Map<String, dynamic> json) =>
      _$FluidOunceFromJson(json);

  @override
  Volume toCubicCentimeter() =>
      CubicCentimeter(cubicCentimeterPerFluidOunce * value);

  @override
  Volume toCup() => Cup(cupPerFluidOunce * value);

  @override
  Volume toFluidOunce() => FluidOunce(value);

  @override
  Volume toLiter() => Liter(literPerFluidOunce * value);

  @override
  Volume toMilliliter() => Milliliter(milliliterPerFluidOunce * value);

  @override
  Volume toTablespoon() => Tablespoon(tablespoonPerFluidOunce * value);

  @override
  Volume toTeaspoon() => Teaspoon(teaspoonPerFluidOunce * value);
}

@freezed
class Cup with _$Cup implements Volume {
  static const abbr = 'cp';

  const Cup._();

  const factory Cup.__(double value, String abbreviation) = _Cup;

  factory Cup(double value) => Cup.__(value, abbr);

  factory Cup.fromJson(Map<String, dynamic> json) => _$CupFromJson(json);

  @override
  Volume toCubicCentimeter() => CubicCentimeter(cubicCentimeterPerCup * value);

  @override
  Volume toCup() => Cup(value);

  @override
  Volume toFluidOunce() => FluidOunce(fluidOuncePerCup * value);

  @override
  Volume toLiter() => Liter(literPerCup * value);

  @override
  Volume toMilliliter() => Milliliter(milliliterPerCup * value);

  @override
  Volume toTablespoon() => Tablespoon(tablespoonPerCup * value);

  @override
  Volume toTeaspoon() => Teaspoon(teaspoonPerCup * value);
}
