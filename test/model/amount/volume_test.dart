import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get abbreviation of volume unit',
    () {
      expect(CubicCentimeter.symbol, 'cc');
      expect(Milliliter.symbol, 'mL');
      expect(Liter.symbol, 'L');
      expect(Teaspoon.symbol, 'tsp');
      expect(Tablespoon.symbol, 'Tbsp');
      expect(FluidOunce.symbol, 'fl.oz');
      expect(Cup.symbol, 'cp');
    },
  );

  test(
    'String expression',
    () {
      expect(const CubicCentimeter(1.555).toStringAsFixed(2), '1.55 cc');
      expect(const Milliliter(1.555).toStringAsFixed(2), '1.55 mL');
      expect(const Liter(1.555).toStringAsFixed(2), '1.55 L');
      expect(const Teaspoon(1.555).toStringAsFixed(2), '1.55 tsp');
      expect(const Tablespoon(1.555).toStringAsFixed(2), '1.55 Tbsp');
      expect(const FluidOunce(1.555).toStringAsFixed(2), '1.55 fl.oz');
      expect(const Cup(1.555).toStringAsFixed(2), '1.55 cp');
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
            const CubicCentimeter(1.0) + const CubicCentimeter(1.0),
            const CubicCentimeter(2.0),
          );
          expect(
            const CubicCentimeter(1.0) + const Milliliter(1.0),
            const CubicCentimeter(1.0 + cubicCentimeterPerMilliliter),
          );
          expect(
            const CubicCentimeter(1.0) + const Liter(1.0),
            const CubicCentimeter(1.0 + cubicCentimeterPerLiter),
          );
          expect(
            const CubicCentimeter(1.0) + const Teaspoon(1.0),
            const CubicCentimeter(1.0 + cubicCentimeterPerTeaspoon),
          );
          expect(
            const CubicCentimeter(1.0) + const Tablespoon(1.0),
            const CubicCentimeter(1.0 + cubicCentimeterPerTablespoon),
          );
          expect(
            const CubicCentimeter(1.0) + const FluidOunce(1.0),
            const CubicCentimeter(1.0 + cubicCentimeterPerFluidOunce),
          );
          expect(
            const CubicCentimeter(1.0) + const Cup(1.0),
            const CubicCentimeter(1.0 + cubicCentimeterPerCup),
          );

          // Milliliter
          expect(
            const Milliliter(1.0) + const CubicCentimeter(1.0),
            const Milliliter(1.0 + milliliterPerCubicCentimeter),
          );
          expect(
            const Milliliter(1.0) + const Milliliter(1.0),
            const Milliliter(2.0),
          );
          expect(
            const Milliliter(1.0) + const Liter(1.0),
            const Milliliter(1.0 + milliliterPerLiter),
          );
          expect(
            const Milliliter(1.0) + const Teaspoon(1.0),
            const Milliliter(1.0 + milliliterPerTeaspoon),
          );
          expect(
            const Milliliter(1.0) + const Tablespoon(1.0),
            const Milliliter(1.0 + milliliterPerTablespoon),
          );
          expect(
            const Milliliter(1.0) + const FluidOunce(1.0),
            const Milliliter(1.0 + milliliterPerFluidOunce),
          );
          expect(
            const Milliliter(1.0) + const Cup(1.0),
            const Milliliter(1.0 + milliliterPerCup),
          );

          // Liter
          expect(
            const Liter(1.0) + const CubicCentimeter(1.0),
            const Liter(1.0 + literPerCubicCentimeter),
          );
          expect(
            const Liter(1.0) + const Milliliter(1.0),
            const Liter(1.0 + literPerMilliliter),
          );
          expect(
            const Liter(1.0) + const Liter(1.0),
            const Liter(2.0),
          );
          expect(
            const Liter(1.0) + const Teaspoon(1.0),
            const Liter(1.0 + literPerTeaspoon),
          );
          expect(
            const Liter(1.0) + const Tablespoon(1.0),
            const Liter(1.0 + literPerTablespoon),
          );
          expect(
            const Liter(1.0) + const FluidOunce(1.0),
            const Liter(1.0 + literPerFluidOunce),
          );
          expect(
            const Liter(1.0) + const Cup(1.0),
            const Liter(1.0 + literPerCup),
          );

          // Teaspoon
          expect(
            const Teaspoon(1.0) + const CubicCentimeter(1.0),
            const Teaspoon(1.0 + teaspoonPerCubicCentimeter),
          );
          expect(
            const Teaspoon(1.0) + const Milliliter(1.0),
            const Teaspoon(1.0 + teaspoonPerMilliliter),
          );
          expect(
            const Teaspoon(1.0) + const Liter(1.0),
            const Teaspoon(1.0 + teaspoonPerLiter),
          );
          expect(
            const Teaspoon(1.0) + const Teaspoon(1.0),
            const Teaspoon(2.0),
          );
          expect(
            const Teaspoon(1.0) + const Tablespoon(1.0),
            const Teaspoon(1.0 + teaspoonPerTablespoon),
          );
          expect(
            const Teaspoon(1.0) + const FluidOunce(1.0),
            const Teaspoon(1.0 + teaspoonPerFluidOunce),
          );
          expect(
            const Teaspoon(1.0) + const Cup(1.0),
            const Teaspoon(1.0 + teaspoonPerCup),
          );

          // Tablespoon
          expect(
            const Tablespoon(1.0) + const CubicCentimeter(1.0),
            const Tablespoon(1.0 + tablespoonPerCubicCentimeter),
          );
          expect(
            const Tablespoon(1.0) + const Milliliter(1.0),
            const Tablespoon(1.0 + tablespoonPerMilliliter),
          );
          expect(
            const Tablespoon(1.0) + const Liter(1.0),
            const Tablespoon(1.0 + tablespoonPerLiter),
          );
          expect(
            const Tablespoon(1.0) + const Teaspoon(1.0),
            const Tablespoon(1.0 + tablespoonPerTeaspoon),
          );
          expect(
            const Tablespoon(1.0) + const Tablespoon(1.0),
            const Tablespoon(2.0),
          );
          expect(
            const Tablespoon(1.0) + const FluidOunce(1.0),
            const Tablespoon(1.0 + tablespoonPerFluidOunce),
          );
          expect(
            const Tablespoon(1.0) + const Cup(1.0),
            const Tablespoon(1.0 + tablespoonPerCup),
          );

          // FluidOunce
          expect(
            const FluidOunce(1.0) + const CubicCentimeter(1.0),
            const FluidOunce(1.0 + fluidOuncePerCubicCentimeter),
          );
          expect(
            const FluidOunce(1.0) + const Milliliter(1.0),
            const FluidOunce(1.0 + fluidOuncePerMilliliter),
          );
          expect(
            const FluidOunce(1.0) + const Liter(1.0),
            const FluidOunce(1.0 + fluidOuncePerLiter),
          );
          expect(
            const FluidOunce(1.0) + const Teaspoon(1.0),
            const FluidOunce(1.0 + fluidOuncePerTeaspoon),
          );
          expect(
            const FluidOunce(1.0) + const Tablespoon(1.0),
            const FluidOunce(1.0 + fluidOuncePerTablespoon),
          );
          expect(
            const FluidOunce(1.0) + const FluidOunce(1.0),
            const FluidOunce(2.0),
          );
          expect(
            const FluidOunce(1.0) + const Cup(1.0),
            const FluidOunce(1.0 + fluidOuncePerCup),
          );

          // Cup
          expect(
            const Cup(1.0) + const CubicCentimeter(1.0),
            const Cup(1.0 + cupPerCubicCentimeter),
          );
          expect(
            const Cup(1.0) + const Milliliter(1.0),
            const Cup(1.0 + cupPerMilliliter),
          );
          expect(
            const Cup(1.0) + const Liter(1.0),
            const Cup(1.0 + cupPerLiter),
          );
          expect(
            const Cup(1.0) + const Teaspoon(1.0),
            const Cup(1.0 + cupPerTeaspoon),
          );
          expect(
            const Cup(1.0) + const Tablespoon(1.0),
            const Cup(1.0 + cupPerTablespoon),
          );
          expect(
            const Cup(1.0) + const FluidOunce(1.0),
            const Cup(1.0 + cupPerFluidOunce),
          );
          expect(
            const Cup(1.0) + const Cup(1.0),
            const Cup(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          // CubicCentimeter
          expect(
            const CubicCentimeter(1.0) - const CubicCentimeter(1.0),
            const CubicCentimeter(0.0),
          );
          expect(
            const CubicCentimeter(1.0) - const Milliliter(1.0),
            const CubicCentimeter(1.0 - cubicCentimeterPerMilliliter),
          );
          expect(
            const CubicCentimeter(1.0) - const Liter(1.0),
            const CubicCentimeter(1.0 - cubicCentimeterPerLiter),
          );
          expect(
            const CubicCentimeter(1.0) - const Teaspoon(1.0),
            const CubicCentimeter(1.0 - cubicCentimeterPerTeaspoon),
          );
          expect(
            const CubicCentimeter(1.0) - const Tablespoon(1.0),
            const CubicCentimeter(1.0 - cubicCentimeterPerTablespoon),
          );
          expect(
            const CubicCentimeter(1.0) - const FluidOunce(1.0),
            const CubicCentimeter(1.0 - cubicCentimeterPerFluidOunce),
          );
          expect(
            const CubicCentimeter(1.0) - const Cup(1.0),
            const CubicCentimeter(1.0 - cubicCentimeterPerCup),
          );

          // Milliliter
          expect(
            const Milliliter(1.0) - const CubicCentimeter(1.0),
            const Milliliter(1.0 - milliliterPerCubicCentimeter),
          );
          expect(
            const Milliliter(1.0) - const Milliliter(1.0),
            const Milliliter(0.0),
          );
          expect(
            const Milliliter(1.0) - const Liter(1.0),
            const Milliliter(1.0 - milliliterPerLiter),
          );
          expect(
            const Milliliter(1.0) - const Teaspoon(1.0),
            const Milliliter(1.0 - milliliterPerTeaspoon),
          );
          expect(
            const Milliliter(1.0) - const Tablespoon(1.0),
            const Milliliter(1.0 - milliliterPerTablespoon),
          );
          expect(
            const Milliliter(1.0) - const FluidOunce(1.0),
            const Milliliter(1.0 - milliliterPerFluidOunce),
          );
          expect(
            const Milliliter(1.0) - const Cup(1.0),
            const Milliliter(1.0 - milliliterPerCup),
          );

          // Liter
          expect(
            const Liter(1.0) - const CubicCentimeter(1.0),
            const Liter(1.0 - literPerCubicCentimeter),
          );
          expect(
            const Liter(1.0) - const Milliliter(1.0),
            const Liter(1.0 - literPerMilliliter),
          );
          expect(
            const Liter(1.0) - const Liter(1.0),
            const Liter(0.0),
          );
          expect(
            const Liter(1.0) - const Teaspoon(1.0),
            const Liter(1.0 - literPerTeaspoon),
          );
          expect(
            const Liter(1.0) - const Tablespoon(1.0),
            const Liter(1.0 - literPerTablespoon),
          );
          expect(
            const Liter(1.0) - const FluidOunce(1.0),
            const Liter(1.0 - literPerFluidOunce),
          );
          expect(
            const Liter(1.0) - const Cup(1.0),
            const Liter(1.0 - literPerCup),
          );

          // Teaspoon
          expect(
            const Teaspoon(1.0) - const CubicCentimeter(1.0),
            const Teaspoon(1.0 - teaspoonPerCubicCentimeter),
          );
          expect(
            const Teaspoon(1.0) - const Milliliter(1.0),
            const Teaspoon(1.0 - teaspoonPerMilliliter),
          );
          expect(
            const Teaspoon(1.0) - const Liter(1.0),
            const Teaspoon(1.0 - teaspoonPerLiter),
          );
          expect(
            const Teaspoon(1.0) - const Teaspoon(1.0),
            const Teaspoon(0.0),
          );
          expect(
            const Teaspoon(1.0) - const Tablespoon(1.0),
            const Teaspoon(1.0 - teaspoonPerTablespoon),
          );
          expect(
            const Teaspoon(1.0) - const FluidOunce(1.0),
            const Teaspoon(1.0 - teaspoonPerFluidOunce),
          );
          expect(
            const Teaspoon(1.0) - const Cup(1.0),
            const Teaspoon(1.0 - teaspoonPerCup),
          );

          // Tablespoon
          expect(
            const Tablespoon(1.0) - const CubicCentimeter(1.0),
            const Tablespoon(1.0 - tablespoonPerCubicCentimeter),
          );
          expect(
            const Tablespoon(1.0) - const Milliliter(1.0),
            const Tablespoon(1.0 - tablespoonPerMilliliter),
          );
          expect(
            const Tablespoon(1.0) - const Liter(1.0),
            const Tablespoon(1.0 - tablespoonPerLiter),
          );
          expect(
            const Tablespoon(1.0) - const Teaspoon(1.0),
            const Tablespoon(1.0 - tablespoonPerTeaspoon),
          );
          expect(
            const Tablespoon(1.0) - const Tablespoon(1.0),
            const Tablespoon(0.0),
          );
          expect(
            const Tablespoon(1.0) - const FluidOunce(1.0),
            const Tablespoon(1.0 - tablespoonPerFluidOunce),
          );
          expect(
            const Tablespoon(1.0) - const Cup(1.0),
            const Tablespoon(1.0 - tablespoonPerCup),
          );

          // FluidOunce
          expect(
            const FluidOunce(1.0) - const CubicCentimeter(1.0),
            const FluidOunce(1.0 - fluidOuncePerCubicCentimeter),
          );
          expect(
            const FluidOunce(1.0) - const Milliliter(1.0),
            const FluidOunce(1.0 - fluidOuncePerMilliliter),
          );
          expect(
            const FluidOunce(1.0) - const Liter(1.0),
            const FluidOunce(1.0 - fluidOuncePerLiter),
          );
          expect(
            const FluidOunce(1.0) - const Teaspoon(1.0),
            const FluidOunce(1.0 - fluidOuncePerTeaspoon),
          );
          expect(
            const FluidOunce(1.0) - const Tablespoon(1.0),
            const FluidOunce(1.0 - fluidOuncePerTablespoon),
          );
          expect(
            const FluidOunce(1.0) - const FluidOunce(1.0),
            const FluidOunce(0.0),
          );
          expect(
            const FluidOunce(1.0) - const Cup(1.0),
            const FluidOunce(1.0 - fluidOuncePerCup),
          );

          // Cup
          expect(
            const Cup(1.0) - const CubicCentimeter(1.0),
            const Cup(1.0 - cupPerCubicCentimeter),
          );
          expect(
            const Cup(1.0) - const Milliliter(1.0),
            const Cup(1.0 - cupPerMilliliter),
          );
          expect(
            const Cup(1.0) - const Liter(1.0),
            const Cup(1.0 - cupPerLiter),
          );
          expect(
            const Cup(1.0) - const Teaspoon(1.0),
            const Cup(1.0 - cupPerTeaspoon),
          );
          expect(
            const Cup(1.0) - const Tablespoon(1.0),
            const Cup(1.0 - cupPerTablespoon),
          );
          expect(
            const Cup(1.0) - const FluidOunce(1.0),
            const Cup(1.0 - cupPerFluidOunce),
          );
          expect(
            const Cup(1.0) - const Cup(1.0),
            const Cup(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(const CubicCentimeter(1.0) * 2, const CubicCentimeter(2.0));
          expect(const Milliliter(1.0) * 2, const Milliliter(2.0));
          expect(const Liter(1.0) * 2, const Liter(2.0));
          expect(const Teaspoon(1.0) * 2, const Teaspoon(2.0));
          expect(const Tablespoon(1.0) * 2, const Tablespoon(2.0));
          expect(const FluidOunce(1.0) * 2, const FluidOunce(2.0));
          expect(const Cup(1.0) * 2, const Cup(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(const CubicCentimeter(2.0) / 2, const CubicCentimeter(1.0));
          expect(const Milliliter(2.0) / 2, const Milliliter(1.0));
          expect(const Liter(2.0) / 2, const Liter(1.0));
          expect(const Teaspoon(2.0) / 2, const Teaspoon(1.0));
          expect(const Tablespoon(2.0) / 2, const Tablespoon(1.0));
          expect(const FluidOunce(2.0) / 2, const FluidOunce(1.0));
          expect(const Cup(2.0) / 2, const Cup(1.0));
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
