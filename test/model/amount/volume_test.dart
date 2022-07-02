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
    '[Arithmetic operation]',
    () {
      test(
        'Addition',
        () {
          // CubicCentimeter
          expect(
            CubicCentimeter(1.0) + CubicCentimeter(1.0),
            CubicCentimeter(2.0),
          );
          expect(
            CubicCentimeter(1.0) + Milliliter(1.0),
            CubicCentimeter(1.0 + cubicCentimeterPerMilliliter),
          );
          expect(
            CubicCentimeter(1.0) + Liter(1.0),
            CubicCentimeter(1.0 + cubicCentimeterPerLiter),
          );
          expect(
            CubicCentimeter(1.0) + Teaspoon(1.0),
            CubicCentimeter(1.0 + cubicCentimeterPerTeaspoon),
          );
          expect(
            CubicCentimeter(1.0) + Tablespoon(1.0),
            CubicCentimeter(1.0 + cubicCentimeterPerTablespoon),
          );
          expect(
            CubicCentimeter(1.0) + FluidOunce(1.0),
            CubicCentimeter(1.0 + cubicCentimeterPerFluidOunce),
          );
          expect(
            CubicCentimeter(1.0) + Cup(1.0),
            CubicCentimeter(1.0 + cubicCentimeterPerCup),
          );

          // Milliliter
          expect(
            Milliliter(1.0) + CubicCentimeter(1.0),
            Milliliter(1.0 + milliliterPerCubicCentimeter),
          );
          expect(
            Milliliter(1.0) + Milliliter(1.0),
            Milliliter(2.0),
          );
          expect(
            Milliliter(1.0) + Liter(1.0),
            Milliliter(1.0 + milliliterPerLiter),
          );
          expect(
            Milliliter(1.0) + Teaspoon(1.0),
            Milliliter(1.0 + milliliterPerTeaspoon),
          );
          expect(
            Milliliter(1.0) + Tablespoon(1.0),
            Milliliter(1.0 + milliliterPerTablespoon),
          );
          expect(
            Milliliter(1.0) + FluidOunce(1.0),
            Milliliter(1.0 + milliliterPerFluidOunce),
          );
          expect(
            Milliliter(1.0) + Cup(1.0),
            Milliliter(1.0 + milliliterPerCup),
          );

          // Liter
          expect(
            Liter(1.0) + CubicCentimeter(1.0),
            Liter(1.0 + literPerCubicCentimeter),
          );
          expect(
            Liter(1.0) + Milliliter(1.0),
            Liter(1.0 + literPerMilliliter),
          );
          expect(
            Liter(1.0) + Liter(1.0),
            Liter(2.0),
          );
          expect(
            Liter(1.0) + Teaspoon(1.0),
            Liter(1.0 + literPerTeaspoon),
          );
          expect(
            Liter(1.0) + Tablespoon(1.0),
            Liter(1.0 + literPerTablespoon),
          );
          expect(
            Liter(1.0) + FluidOunce(1.0),
            Liter(1.0 + literPerFluidOunce),
          );
          expect(
            Liter(1.0) + Cup(1.0),
            Liter(1.0 + literPerCup),
          );

          // Teaspoon
          expect(
            Teaspoon(1.0) + CubicCentimeter(1.0),
            Teaspoon(1.0 + teaspoonPerCubicCentimeter),
          );
          expect(
            Teaspoon(1.0) + Milliliter(1.0),
            Teaspoon(1.0 + teaspoonPerMilliliter),
          );
          expect(
            Teaspoon(1.0) + Liter(1.0),
            Teaspoon(1.0 + teaspoonPerLiter),
          );
          expect(
            Teaspoon(1.0) + Teaspoon(1.0),
            Teaspoon(2.0),
          );
          expect(
            Teaspoon(1.0) + Tablespoon(1.0),
            Teaspoon(1.0 + teaspoonPerTablespoon),
          );
          expect(
            Teaspoon(1.0) + FluidOunce(1.0),
            Teaspoon(1.0 + teaspoonPerFluidOunce),
          );
          expect(
            Teaspoon(1.0) + Cup(1.0),
            Teaspoon(1.0 + teaspoonPerCup),
          );

          // Tablespoon
          expect(
            Tablespoon(1.0) + CubicCentimeter(1.0),
            Tablespoon(1.0 + tablespoonPerCubicCentimeter),
          );
          expect(
            Tablespoon(1.0) + Milliliter(1.0),
            Tablespoon(1.0 + tablespoonPerMilliliter),
          );
          expect(
            Tablespoon(1.0) + Liter(1.0),
            Tablespoon(1.0 + tablespoonPerLiter),
          );
          expect(
            Tablespoon(1.0) + Teaspoon(1.0),
            Tablespoon(1.0 + tablespoonPerTeaspoon),
          );
          expect(
            Tablespoon(1.0) + Tablespoon(1.0),
            Tablespoon(2.0),
          );
          expect(
            Tablespoon(1.0) + FluidOunce(1.0),
            Tablespoon(1.0 + tablespoonPerFluidOunce),
          );
          expect(
            Tablespoon(1.0) + Cup(1.0),
            Tablespoon(1.0 + tablespoonPerCup),
          );

          // FluidOunce
          expect(
            FluidOunce(1.0) + CubicCentimeter(1.0),
            FluidOunce(1.0 + fluidOuncePerCubicCentimeter),
          );
          expect(
            FluidOunce(1.0) + Milliliter(1.0),
            FluidOunce(1.0 + fluidOuncePerMilliliter),
          );
          expect(
            FluidOunce(1.0) + Liter(1.0),
            FluidOunce(1.0 + fluidOuncePerLiter),
          );
          expect(
            FluidOunce(1.0) + Teaspoon(1.0),
            FluidOunce(1.0 + fluidOuncePerTeaspoon),
          );
          expect(
            FluidOunce(1.0) + Tablespoon(1.0),
            FluidOunce(1.0 + fluidOuncePerTablespoon),
          );
          expect(
            FluidOunce(1.0) + FluidOunce(1.0),
            FluidOunce(2.0),
          );
          expect(
            FluidOunce(1.0) + Cup(1.0),
            FluidOunce(1.0 + fluidOuncePerCup),
          );

          // Cup
          expect(
            Cup(1.0) + CubicCentimeter(1.0),
            Cup(1.0 + cupPerCubicCentimeter),
          );
          expect(
            Cup(1.0) + Milliliter(1.0),
            Cup(1.0 + cupPerMilliliter),
          );
          expect(
            Cup(1.0) + Liter(1.0),
            Cup(1.0 + cupPerLiter),
          );
          expect(
            Cup(1.0) + Teaspoon(1.0),
            Cup(1.0 + cupPerTeaspoon),
          );
          expect(
            Cup(1.0) + Tablespoon(1.0),
            Cup(1.0 + cupPerTablespoon),
          );
          expect(
            Cup(1.0) + FluidOunce(1.0),
            Cup(1.0 + cupPerFluidOunce),
          );
          expect(
            Cup(1.0) + Cup(1.0),
            Cup(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          // CubicCentimeter
          expect(
            CubicCentimeter(1.0) - CubicCentimeter(1.0),
            CubicCentimeter(0.0),
          );
          expect(
            CubicCentimeter(1.0) - Milliliter(1.0),
            CubicCentimeter(1.0 - cubicCentimeterPerMilliliter),
          );
          expect(
            CubicCentimeter(1.0) - Liter(1.0),
            CubicCentimeter(1.0 - cubicCentimeterPerLiter),
          );
          expect(
            CubicCentimeter(1.0) - Teaspoon(1.0),
            CubicCentimeter(1.0 - cubicCentimeterPerTeaspoon),
          );
          expect(
            CubicCentimeter(1.0) - Tablespoon(1.0),
            CubicCentimeter(1.0 - cubicCentimeterPerTablespoon),
          );
          expect(
            CubicCentimeter(1.0) - FluidOunce(1.0),
            CubicCentimeter(1.0 - cubicCentimeterPerFluidOunce),
          );
          expect(
            CubicCentimeter(1.0) - Cup(1.0),
            CubicCentimeter(1.0 - cubicCentimeterPerCup),
          );

          // Milliliter
          expect(
            Milliliter(1.0) - CubicCentimeter(1.0),
            Milliliter(1.0 - milliliterPerCubicCentimeter),
          );
          expect(
            Milliliter(1.0) - Milliliter(1.0),
            Milliliter(0.0),
          );
          expect(
            Milliliter(1.0) - Liter(1.0),
            Milliliter(1.0 - milliliterPerLiter),
          );
          expect(
            Milliliter(1.0) - Teaspoon(1.0),
            Milliliter(1.0 - milliliterPerTeaspoon),
          );
          expect(
            Milliliter(1.0) - Tablespoon(1.0),
            Milliliter(1.0 - milliliterPerTablespoon),
          );
          expect(
            Milliliter(1.0) - FluidOunce(1.0),
            Milliliter(1.0 - milliliterPerFluidOunce),
          );
          expect(
            Milliliter(1.0) - Cup(1.0),
            Milliliter(1.0 - milliliterPerCup),
          );

          // Liter
          expect(
            Liter(1.0) - CubicCentimeter(1.0),
            Liter(1.0 - literPerCubicCentimeter),
          );
          expect(
            Liter(1.0) - Milliliter(1.0),
            Liter(1.0 - literPerMilliliter),
          );
          expect(
            Liter(1.0) - Liter(1.0),
            Liter(0.0),
          );
          expect(
            Liter(1.0) - Teaspoon(1.0),
            Liter(1.0 - literPerTeaspoon),
          );
          expect(
            Liter(1.0) - Tablespoon(1.0),
            Liter(1.0 - literPerTablespoon),
          );
          expect(
            Liter(1.0) - FluidOunce(1.0),
            Liter(1.0 - literPerFluidOunce),
          );
          expect(
            Liter(1.0) - Cup(1.0),
            Liter(1.0 - literPerCup),
          );

          // Teaspoon
          expect(
            Teaspoon(1.0) - CubicCentimeter(1.0),
            Teaspoon(1.0 - teaspoonPerCubicCentimeter),
          );
          expect(
            Teaspoon(1.0) - Milliliter(1.0),
            Teaspoon(1.0 - teaspoonPerMilliliter),
          );
          expect(
            Teaspoon(1.0) - Liter(1.0),
            Teaspoon(1.0 - teaspoonPerLiter),
          );
          expect(
            Teaspoon(1.0) - Teaspoon(1.0),
            Teaspoon(0.0),
          );
          expect(
            Teaspoon(1.0) - Tablespoon(1.0),
            Teaspoon(1.0 - teaspoonPerTablespoon),
          );
          expect(
            Teaspoon(1.0) - FluidOunce(1.0),
            Teaspoon(1.0 - teaspoonPerFluidOunce),
          );
          expect(
            Teaspoon(1.0) - Cup(1.0),
            Teaspoon(1.0 - teaspoonPerCup),
          );

          // Tablespoon
          expect(
            Tablespoon(1.0) - CubicCentimeter(1.0),
            Tablespoon(1.0 - tablespoonPerCubicCentimeter),
          );
          expect(
            Tablespoon(1.0) - Milliliter(1.0),
            Tablespoon(1.0 - tablespoonPerMilliliter),
          );
          expect(
            Tablespoon(1.0) - Liter(1.0),
            Tablespoon(1.0 - tablespoonPerLiter),
          );
          expect(
            Tablespoon(1.0) - Teaspoon(1.0),
            Tablespoon(1.0 - tablespoonPerTeaspoon),
          );
          expect(
            Tablespoon(1.0) - Tablespoon(1.0),
            Tablespoon(0.0),
          );
          expect(
            Tablespoon(1.0) - FluidOunce(1.0),
            Tablespoon(1.0 - tablespoonPerFluidOunce),
          );
          expect(
            Tablespoon(1.0) - Cup(1.0),
            Tablespoon(1.0 - tablespoonPerCup),
          );

          // FluidOunce
          expect(
            FluidOunce(1.0) - CubicCentimeter(1.0),
            FluidOunce(1.0 - fluidOuncePerCubicCentimeter),
          );
          expect(
            FluidOunce(1.0) - Milliliter(1.0),
            FluidOunce(1.0 - fluidOuncePerMilliliter),
          );
          expect(
            FluidOunce(1.0) - Liter(1.0),
            FluidOunce(1.0 - fluidOuncePerLiter),
          );
          expect(
            FluidOunce(1.0) - Teaspoon(1.0),
            FluidOunce(1.0 - fluidOuncePerTeaspoon),
          );
          expect(
            FluidOunce(1.0) - Tablespoon(1.0),
            FluidOunce(1.0 - fluidOuncePerTablespoon),
          );
          expect(
            FluidOunce(1.0) - FluidOunce(1.0),
            FluidOunce(0.0),
          );
          expect(
            FluidOunce(1.0) - Cup(1.0),
            FluidOunce(1.0 - fluidOuncePerCup),
          );

          // Cup
          expect(
            Cup(1.0) - CubicCentimeter(1.0),
            Cup(1.0 - cupPerCubicCentimeter),
          );
          expect(
            Cup(1.0) - Milliliter(1.0),
            Cup(1.0 - cupPerMilliliter),
          );
          expect(
            Cup(1.0) - Liter(1.0),
            Cup(1.0 - cupPerLiter),
          );
          expect(
            Cup(1.0) - Teaspoon(1.0),
            Cup(1.0 - cupPerTeaspoon),
          );
          expect(
            Cup(1.0) - Tablespoon(1.0),
            Cup(1.0 - cupPerTablespoon),
          );
          expect(
            Cup(1.0) - FluidOunce(1.0),
            Cup(1.0 - cupPerFluidOunce),
          );
          expect(
            Cup(1.0) - Cup(1.0),
            Cup(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(CubicCentimeter(1.0) * 2, CubicCentimeter(2.0));
          expect(Milliliter(1.0) * 2, Milliliter(2.0));
          expect(Liter(1.0) * 2, Liter(2.0));
          expect(Teaspoon(1.0) * 2, Teaspoon(2.0));
          expect(Tablespoon(1.0) * 2, Tablespoon(2.0));
          expect(FluidOunce(1.0) * 2, FluidOunce(2.0));
          expect(Cup(1.0) * 2, Cup(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(CubicCentimeter(2.0) / 2, CubicCentimeter(1.0));
          expect(Milliliter(2.0) / 2, Milliliter(1.0));
          expect(Liter(2.0) / 2, Liter(1.0));
          expect(Teaspoon(2.0) / 2, Teaspoon(1.0));
          expect(Tablespoon(2.0) / 2, Tablespoon(1.0));
          expect(FluidOunce(2.0) / 2, FluidOunce(1.0));
          expect(Cup(2.0) / 2, Cup(1.0));
        },
      );
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
