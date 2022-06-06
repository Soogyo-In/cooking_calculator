import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get abbreviation of volume unit',
    () {
      expect(CubicCentimeter.abbr, 'cc');
      expect(Milliliter.abbr, 'mL');
      expect(Liter.abbr, 'L');
      expect(Teaspoon.abbr, 'tsp');
      expect(Tablespoon.abbr, 'Tbsp');
      expect(FluidOunce.abbr, 'fl.oz');
      expect(Cup.abbr, 'cp');

      expect(CubicCentimeter(0.0).abbreviation, 'cc');
      expect(Milliliter(0.0).abbreviation, 'mL');
      expect(Liter(0.0).abbreviation, 'L');
      expect(Teaspoon(0.0).abbreviation, 'tsp');
      expect(Tablespoon(0.0).abbreviation, 'Tbsp');
      expect(FluidOunce(0.0).abbreviation, 'fl.oz');
      expect(Cup(0.0).abbreviation, 'cp');
    },
  );

  group(
    '[Convert volume unit]',
    () {
      late Volume cubicCentimeter;
      late Volume milliliter;
      late Volume liter;
      late Volume teaspoon;
      late Volume tablespoon;
      late Volume fluidOunce;
      late Volume cup;

      setUp(() {
        cubicCentimeter = Volume.cubicCentimeter(1.0);
        milliliter = Volume.milliliter(1.0);
        liter = Volume.liter(1.0);
        teaspoon = Volume.teaspoon(1.0);
        tablespoon = Volume.tablespoon(1.0);
        fluidOunce = Volume.fluidOunce(1.0);
        cup = Volume.cup(1.0);
      });

      test(
        'Convert to cubic centimeter',
        () {
          expect(
            cubicCentimeter.toCubicCentimeter(),
            Volume.cubicCentimeter(1.0),
          );
          expect(
            milliliter.toCubicCentimeter(),
            Volume.cubicCentimeter(cubicCentimeterPerMilliliter),
          );
          expect(
            liter.toCubicCentimeter(),
            Volume.cubicCentimeter(cubicCentimeterPerLiter),
          );
          expect(
            teaspoon.toCubicCentimeter(),
            Volume.cubicCentimeter(cubicCentimeterPerTeaspoon),
          );
          expect(
            tablespoon.toCubicCentimeter(),
            Volume.cubicCentimeter(cubicCentimeterPerTablespoon),
          );
          expect(
            fluidOunce.toCubicCentimeter(),
            Volume.cubicCentimeter(cubicCentimeterPerFluidOunce),
          );
          expect(
            cup.toCubicCentimeter(),
            Volume.cubicCentimeter(cubicCentimeterPerCup),
          );
        },
      );

      test(
        'Convert to milliliter',
        () {
          expect(
            cubicCentimeter.toMilliliter(),
            Volume.milliliter(milliliterPerCubicCentimeter),
          );
          expect(
            milliliter.toMilliliter(),
            Volume.milliliter(1.0),
          );
          expect(
            liter.toMilliliter(),
            Volume.milliliter(milliliterPerLiter),
          );
          expect(
            teaspoon.toMilliliter(),
            Volume.milliliter(milliliterPerTeaspoon),
          );
          expect(
            tablespoon.toMilliliter(),
            Volume.milliliter(milliliterPerTablespoon),
          );
          expect(
            fluidOunce.toMilliliter(),
            Volume.milliliter(milliliterPerFluidOunce),
          );
          expect(
            cup.toMilliliter(),
            Volume.milliliter(milliliterPerCup),
          );
        },
      );

      test(
        'Convert to liter',
        () {
          expect(
            cubicCentimeter.toLiter(),
            Volume.liter(literPerCubicCentimeter),
          );
          expect(
            milliliter.toLiter(),
            Volume.liter(literPerMilliliter),
          );
          expect(
            liter.toLiter(),
            Volume.liter(1.0),
          );
          expect(
            teaspoon.toLiter(),
            Volume.liter(literPerTeaspoon),
          );
          expect(
            tablespoon.toLiter(),
            Volume.liter(literPerTablespoon),
          );
          expect(
            fluidOunce.toLiter(),
            Volume.liter(literPerFluidOunce),
          );
          expect(
            cup.toLiter(),
            Volume.liter(literPerCup),
          );
        },
      );

      test(
        'Convert to teaspoon',
        () {
          expect(
            cubicCentimeter.toTeaspoon(),
            Volume.teaspoon(teaspoonPerCubicCentimeter),
          );
          expect(
            milliliter.toTeaspoon(),
            Volume.teaspoon(teaspoonPerMilliliter),
          );
          expect(
            liter.toTeaspoon(),
            Volume.teaspoon(teaspoonPerLiter),
          );
          expect(
            teaspoon.toTeaspoon(),
            Volume.teaspoon(1.0),
          );
          expect(
            tablespoon.toTeaspoon(),
            Volume.teaspoon(teaspoonPerTablespoon),
          );
          expect(
            fluidOunce.toTeaspoon(),
            Volume.teaspoon(teaspoonPerFluidOunce),
          );
          expect(
            cup.toTeaspoon(),
            Volume.teaspoon(teaspoonPerCup),
          );
        },
      );

      test(
        'Convert to tablespoon',
        () {
          expect(
            cubicCentimeter.toTablespoon(),
            Volume.tablespoon(tablespoonPerCubicCentimeter),
          );
          expect(
            milliliter.toTablespoon(),
            Volume.tablespoon(tablespoonPerMilliliter),
          );
          expect(
            liter.toTablespoon(),
            Volume.tablespoon(tablespoonPerLiter),
          );
          expect(
            teaspoon.toTablespoon(),
            Volume.tablespoon(tablespoonPerTeaspoon),
          );
          expect(
            tablespoon.toTablespoon(),
            Volume.tablespoon(1.0),
          );
          expect(
            fluidOunce.toTablespoon(),
            Volume.tablespoon(tablespoonPerFluidOunce),
          );
          expect(
            cup.toTablespoon(),
            Volume.tablespoon(tablespoonPerCup),
          );
        },
      );

      test(
        'Convert to fluid ounce',
        () {
          expect(
            cubicCentimeter.toFluidOunce(),
            Volume.fluidOunce(fluidOuncePerCubicCentimeter),
          );
          expect(
            milliliter.toFluidOunce(),
            Volume.fluidOunce(fluidOuncePerMilliliter),
          );
          expect(
            liter.toFluidOunce(),
            Volume.fluidOunce(fluidOuncePerLiter),
          );
          expect(
            teaspoon.toFluidOunce(),
            Volume.fluidOunce(fluidOuncePerTeaspoon),
          );
          expect(
            tablespoon.toFluidOunce(),
            Volume.fluidOunce(fluidOuncePerTablespoon),
          );
          expect(
            fluidOunce.toFluidOunce(),
            Volume.fluidOunce(1.0),
          );
          expect(
            cup.toFluidOunce(),
            Volume.fluidOunce(fluidOuncePerCup),
          );
        },
      );

      test(
        'Convert to cup',
        () {
          expect(
            cubicCentimeter.toCup(),
            Volume.cup(cupPerCubicCentimeter),
          );
          expect(
            milliliter.toCup(),
            Volume.cup(cupPerMilliliter),
          );
          expect(
            liter.toCup(),
            Volume.cup(cupPerLiter),
          );
          expect(
            teaspoon.toCup(),
            Volume.cup(cupPerTeaspoon),
          );
          expect(
            tablespoon.toCup(),
            Volume.cup(cupPerTablespoon),
          );
          expect(
            fluidOunce.toCup(),
            Volume.cup(cupPerFluidOunce),
          );
          expect(
            cup.toCup(),
            Volume.cup(1.0),
          );
        },
      );
    },
  );
}
