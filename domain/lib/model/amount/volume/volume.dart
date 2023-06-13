import 'package:domain/model/amount/amount.dart';
import 'package:domain/model/extension/extension.dart';

part 'cubic_centimeter.dart';
part 'cup.dart';
part 'fluid_ounce.dart';
part 'liter.dart';
part 'milliliter.dart';
part 'tablespoon.dart';
part 'teaspoon.dart';

const milliliterPerLiter = 1000.0;
const milliliterPerTeaspoon = 4.92892159375;
const milliliterPerTablespoon = 14.78676478125;
const milliliterPerFluidOunce = 29.5735295625;
const milliliterPerCup = 236.5882365;

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

const cubicCentimeterPerLiter = milliliterPerLiter;
const teaspoonPerLiter = teaspoonPerMilliliter * milliliterPerLiter;
const tablespoonPerLiter = tablespoonPerMilliliter * milliliterPerLiter;
const fluidOuncePerLiter = fluidOuncePerMilliliter * milliliterPerLiter;
const cupPerLiter = cupPerMilliliter * milliliterPerLiter;

const cubicCentimeterPerTeaspoon = milliliterPerTeaspoon;
const literPerTeaspoon = literPerMilliliter * milliliterPerTeaspoon;
const tablespoonPerTeaspoon = tablespoonPerMilliliter * milliliterPerTeaspoon;
const fluidOuncePerTeaspoon = fluidOuncePerMilliliter * milliliterPerTeaspoon;
const cupPerTeaspoon = cupPerMilliliter * milliliterPerTeaspoon;

const cubicCentimeterPerTablespoon = milliliterPerTablespoon;
const literPerTablespoon = literPerMilliliter * milliliterPerTablespoon;
const teaspoonPerTablespoon = teaspoonPerMilliliter * milliliterPerTablespoon;
const fluidOuncePerTablespoon =
    fluidOuncePerMilliliter * milliliterPerTablespoon;
const cupPerTablespoon = cupPerMilliliter * milliliterPerTablespoon;

const cubicCentimeterPerFluidOunce = milliliterPerFluidOunce;
const literPerFluidOunce = literPerMilliliter * milliliterPerFluidOunce;
const teaspoonPerFluidOunce = teaspoonPerMilliliter * milliliterPerFluidOunce;
const tablespoonPerFluidOunce =
    tablespoonPerMilliliter * milliliterPerFluidOunce;
const cupPerFluidOunce = cupPerMilliliter * milliliterPerFluidOunce;

const cubicCentimeterPerCup = milliliterPerCup;
const literPerCup = literPerMilliliter * milliliterPerCup;
const teaspoonPerCup = teaspoonPerMilliliter * milliliterPerCup;
const tablespoonPerCup = tablespoonPerMilliliter * milliliterPerCup;
const fluidOuncePerCup = fluidOuncePerMilliliter * milliliterPerCup;

sealed class Volume extends Amount {
  Volume({
    required super.value,
    required super.symbol,
  });

  factory Volume.cubicCentimeter(int value) = CubicCentimeter;

  factory Volume.milliliter(int value) = Milliliter;

  factory Volume.liter(double value) = Liter;

  factory Volume.teaspoon(double value) = Teaspoon;

  factory Volume.tablespoon(double value) = Tablespoon;

  factory Volume.fluidOunce(double value) = FluidOunce;

  factory Volume.cup(double value) = Cup;

  int get _inMilliliters;

  @override
  List<Object?> get props => super.props..add(_inMilliliters);

  CubicCentimeter toCubicCentimeter();

  Milliliter toMilliliter();

  Liter toLiter();

  Teaspoon toTeaspoon();

  Tablespoon toTablespoon();

  FluidOunce toFluidOunce();

  Cup toCup();

  @override
  Volume operator +(Volume other);

  @override
  Volume operator -(Volume other);

  @override
  Volume operator *(num factor);

  @override
  Volume operator /(num divisor);

  @override
  bool operator <(covariant Volume other) => compareTo(other) < 0;

  @override
  bool operator >(covariant Volume other) => compareTo(other) > 0;

  @override
  bool operator <=(covariant Volume other) => compareTo(other) <= 0;

  @override
  bool operator >=(covariant Volume other) => compareTo(other) >= 0;

  @override
  int compareTo(covariant Volume other) =>
      _inMilliliters.compareTo(other._inMilliliters);
}
