import 'package:freezed_annotation/freezed_annotation.dart';

import '../amount.dart';

part 'cubic_centimeter.dart';
part 'cup.dart';
part 'fluid_ounce.dart';
part 'liter.dart';
part 'milliliter.dart';
part 'tablespoon.dart';
part 'teaspoon.dart';
part 'volume.freezed.dart';

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
  const factory Volume.cubicCentimeter(double value) = CubicCentimeter;

  const factory Volume.milliliter(double value) = Milliliter;

  const factory Volume.liter(double value) = Liter;

  const factory Volume.teaspoon(double value) = Teaspoon;

  const factory Volume.tablespoon(double value) = Tablespoon;

  const factory Volume.fluidOunce(double value) = FluidOunce;

  const factory Volume.cup(double value) = Cup;

  CubicCentimeter toCubicCentimeter();

  Milliliter toMilliliter();

  Liter toLiter();

  Teaspoon toTeaspoon();

  Tablespoon toTablespoon();

  FluidOunce toFluidOunce();

  Cup toCup();
}
