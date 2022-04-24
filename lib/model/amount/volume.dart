part of 'amount.dart';

enum VolumeUnit {
  cubicCentimeter,
  milliliter,
  liter,
  teaspoon,
  tablespoon,
  fluidOunce,
  cup,
}

extension VolumeUnitExpression on VolumeUnit {
  String get abbreviation {
    switch (this) {
      case VolumeUnit.cubicCentimeter:
        return 'cc';
      case VolumeUnit.milliliter:
        return 'mL';
      case VolumeUnit.liter:
        return 'L';
      case VolumeUnit.teaspoon:
        return 'tsp';
      case VolumeUnit.tablespoon:
        return 'Tbsp';
      case VolumeUnit.fluidOunce:
        return 'fl.oz';
      case VolumeUnit.cup:
        return 'cp';
    }
  }
}

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
const tableSpoonPerTeaspoon = tablespoonPerMilliliter * milliliterPerTeaspoon;
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

@freezed
class Volume with _$Volume implements Amount {
  const Volume._();

  factory Volume.__(double value, VolumeUnit unit) = _Volume;

  factory Volume(double value, VolumeUnit unit) {
    if (value.isNegative) throw NegativeValueException();
    return Volume.__(value, unit);
  }

  factory Volume.cubicCentimeter(double value) =>
      Volume(value, VolumeUnit.cubicCentimeter);

  factory Volume.milliliter(double value) =>
      Volume(value, VolumeUnit.milliliter);

  factory Volume.liter(double value) => Volume(value, VolumeUnit.liter);

  factory Volume.teaspoon(double value) => Volume(value, VolumeUnit.teaspoon);

  factory Volume.tablespoon(double value) =>
      Volume(value, VolumeUnit.tablespoon);

  factory Volume.fluidOunce(double value) =>
      Volume(value, VolumeUnit.fluidOunce);

  factory Volume.cup(double value) => Volume(value, VolumeUnit.cup);

  factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);

  Volume toCubicCentimeter() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return this;
      case VolumeUnit.milliliter:
        return Volume.cubicCentimeter(value * cubicCentimeterPerMilliliter);
      case VolumeUnit.liter:
        return Volume.cubicCentimeter(value * cubicCentimeterPerLiter);
      case VolumeUnit.teaspoon:
        return Volume.cubicCentimeter(value * cubicCentimeterPerTeaspoon);
      case VolumeUnit.tablespoon:
        return Volume.cubicCentimeter(value * cubicCentimeterPerTablespoon);
      case VolumeUnit.fluidOunce:
        return Volume.cubicCentimeter(value * cubicCentimeterPerFluidOunce);
      case VolumeUnit.cup:
        return Volume.cubicCentimeter(value * cubicCentimeterPerCup);
    }
  }

  Volume toMilliliter() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return Volume.milliliter(value * milliliterPerCubicCentimeter);
      case VolumeUnit.milliliter:
        return this;
      case VolumeUnit.liter:
        return Volume.milliliter(value * milliliterPerLiter);
      case VolumeUnit.teaspoon:
        return Volume.milliliter(value * milliliterPerTeaspoon);
      case VolumeUnit.tablespoon:
        return Volume.milliliter(value * milliliterPerTablespoon);
      case VolumeUnit.fluidOunce:
        return Volume.milliliter(value * milliliterPerFluidOunce);
      case VolumeUnit.cup:
        return Volume.milliliter(value * milliliterPerCup);
    }
  }

  Volume toLiter() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return Volume.liter(value * literPerCubicCentimeter);
      case VolumeUnit.milliliter:
        return Volume.liter(value * literPerMilliliter);
      case VolumeUnit.liter:
        return this;
      case VolumeUnit.teaspoon:
        return Volume.liter(value * literPerTeaspoon);
      case VolumeUnit.tablespoon:
        return Volume.liter(value * literPerTablespoon);
      case VolumeUnit.fluidOunce:
        return Volume.liter(value * literPerFluidOunce);
      case VolumeUnit.cup:
        return Volume.liter(value * literPerCup);
    }
  }

  Volume toTeaspoon() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return Volume.teaspoon(value * teaspoonPerCubicCentimeter);
      case VolumeUnit.milliliter:
        return Volume.teaspoon(value * teaspoonPerMilliliter);
      case VolumeUnit.liter:
        return Volume.teaspoon(value * teaspoonPerLiter);
      case VolumeUnit.teaspoon:
        return this;
      case VolumeUnit.tablespoon:
        return Volume.teaspoon(value * teaspoonPerTablespoon);
      case VolumeUnit.fluidOunce:
        return Volume.teaspoon(value * teaspoonPerFluidOunce);
      case VolumeUnit.cup:
        return Volume.teaspoon(value * teaspoonPerCup);
    }
  }

  Volume toTablespoon() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return Volume.tablespoon(value * tablespoonPerCubicCentimeter);
      case VolumeUnit.milliliter:
        return Volume.tablespoon(value * tablespoonPerMilliliter);
      case VolumeUnit.liter:
        return Volume.tablespoon(value * tablespoonPerLiter);
      case VolumeUnit.teaspoon:
        return Volume.tablespoon(value * tableSpoonPerTeaspoon);
      case VolumeUnit.tablespoon:
        return this;
      case VolumeUnit.fluidOunce:
        return Volume.tablespoon(value * tablespoonPerFluidOunce);
      case VolumeUnit.cup:
        return Volume.tablespoon(value * tablespoonPerCup);
    }
  }

  Volume toFluidOunce() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return Volume.fluidOunce(value * fluidOuncePerCubicCentimeter);
      case VolumeUnit.milliliter:
        return Volume.fluidOunce(value * fluidOuncePerMilliliter);
      case VolumeUnit.liter:
        return Volume.fluidOunce(value * fluidOuncePerLiter);
      case VolumeUnit.teaspoon:
        return Volume.fluidOunce(value * fluidOuncePerTeaspoon);
      case VolumeUnit.tablespoon:
        return Volume.fluidOunce(value * fluidOuncePerTablespoon);
      case VolumeUnit.fluidOunce:
        return this;
      case VolumeUnit.cup:
        return Volume.fluidOunce(value * fluidOuncePerCup);
    }
  }

  Volume toCup() {
    switch (unit) {
      case VolumeUnit.cubicCentimeter:
        return Volume.cup(value * cupPerCubicCentimeter);
      case VolumeUnit.milliliter:
        return Volume.cup(value * cupPerMilliliter);
      case VolumeUnit.liter:
        return Volume.cup(value * cupPerLiter);
      case VolumeUnit.teaspoon:
        return Volume.cup(value * cupPerTeaspoon);
      case VolumeUnit.tablespoon:
        return Volume.cup(value * cupPerTablespoon);
      case VolumeUnit.fluidOunce:
        return Volume.cup(value * cupPerFluidOunce);
      case VolumeUnit.cup:
        return this;
    }
  }
}
