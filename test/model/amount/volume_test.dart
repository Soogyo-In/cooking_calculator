import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get symbol of volume unit',
    () {
      expect(cubicCentimeterSymbol, 'cc');
      expect(milliliterSymbol, 'mL');
      expect(literSymbol, 'L');
      expect(teaspoonSymbol, 'tsp');
      expect(tablespoonSymbol, 'Tbsp');
      expect(fluidOunceSymbol, 'fl.oz');
      expect(cupSymbol, 'cp');
    },
  );

  test(
    'Get Volume object rounded value at specified fraction digits',
    () {
      expect(
        const CubicCentimeter(1.55).roundedAt(2),
        const CubicCentimeter(1.6),
      );
      expect(
        const Milliliter(1.55).roundedAt(2),
        const Milliliter(1.6),
      );
      expect(
        const Liter(1.55).roundedAt(2),
        const Liter(1.6),
      );
      expect(
        const Teaspoon(1.55).roundedAt(2),
        const Teaspoon(1.6),
      );
      expect(
        const Tablespoon(1.55).roundedAt(2),
        const Tablespoon(1.6),
      );
      expect(
        const FluidOunce(1.55).roundedAt(2),
        const FluidOunce(1.6),
      );
      expect(
        const Cup(1.55).roundedAt(2),
        const Cup(1.6),
      );
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
        cubicCentimeter = const Volume.cubicCentimeter(1.0);
        milliliter = const Volume.milliliter(1.0);
        liter = const Volume.liter(1.0);
        teaspoon = const Volume.teaspoon(1.0);
        tablespoon = const Volume.tablespoon(1.0);
        fluidOunce = const Volume.fluidOunce(1.0);
        cup = const Volume.cup(1.0);
      });

      test(
        'Convert to cubic centimeter',
        () {
          expect(
            cubicCentimeter.toCubicCentimeter(),
            const Volume.cubicCentimeter(1.0),
          );
          expect(
            milliliter.toCubicCentimeter(),
            const Volume.cubicCentimeter(cubicCentimeterPerMilliliter),
          );
          expect(
            liter.toCubicCentimeter(),
            const Volume.cubicCentimeter(cubicCentimeterPerLiter),
          );
          expect(
            teaspoon.toCubicCentimeter(),
            const Volume.cubicCentimeter(cubicCentimeterPerTeaspoon),
          );
          expect(
            tablespoon.toCubicCentimeter(),
            const Volume.cubicCentimeter(cubicCentimeterPerTablespoon),
          );
          expect(
            fluidOunce.toCubicCentimeter(),
            const Volume.cubicCentimeter(cubicCentimeterPerFluidOunce),
          );
          expect(
            cup.toCubicCentimeter(),
            const Volume.cubicCentimeter(cubicCentimeterPerCup),
          );
        },
      );

      test(
        'Convert to milliliter',
        () {
          expect(
            cubicCentimeter.toMilliliter(),
            const Volume.milliliter(milliliterPerCubicCentimeter),
          );
          expect(
            milliliter.toMilliliter(),
            const Volume.milliliter(1.0),
          );
          expect(
            liter.toMilliliter(),
            const Volume.milliliter(milliliterPerLiter),
          );
          expect(
            teaspoon.toMilliliter(),
            const Volume.milliliter(milliliterPerTeaspoon),
          );
          expect(
            tablespoon.toMilliliter(),
            const Volume.milliliter(milliliterPerTablespoon),
          );
          expect(
            fluidOunce.toMilliliter(),
            const Volume.milliliter(milliliterPerFluidOunce),
          );
          expect(
            cup.toMilliliter(),
            const Volume.milliliter(milliliterPerCup),
          );
        },
      );

      test(
        'Convert to liter',
        () {
          expect(
            cubicCentimeter.toLiter(),
            const Volume.liter(literPerCubicCentimeter),
          );
          expect(
            milliliter.toLiter(),
            const Volume.liter(literPerMilliliter),
          );
          expect(
            liter.toLiter(),
            const Volume.liter(1.0),
          );
          expect(
            teaspoon.toLiter(),
            const Volume.liter(literPerTeaspoon),
          );
          expect(
            tablespoon.toLiter(),
            const Volume.liter(literPerTablespoon),
          );
          expect(
            fluidOunce.toLiter(),
            const Volume.liter(literPerFluidOunce),
          );
          expect(
            cup.toLiter(),
            const Volume.liter(literPerCup),
          );
        },
      );

      test(
        'Convert to teaspoon',
        () {
          expect(
            cubicCentimeter.toTeaspoon(),
            const Volume.teaspoon(teaspoonPerCubicCentimeter),
          );
          expect(
            milliliter.toTeaspoon(),
            const Volume.teaspoon(teaspoonPerMilliliter),
          );
          expect(
            liter.toTeaspoon(),
            const Volume.teaspoon(teaspoonPerLiter),
          );
          expect(
            teaspoon.toTeaspoon(),
            const Volume.teaspoon(1.0),
          );
          expect(
            tablespoon.toTeaspoon(),
            const Volume.teaspoon(teaspoonPerTablespoon),
          );
          expect(
            fluidOunce.toTeaspoon(),
            const Volume.teaspoon(teaspoonPerFluidOunce),
          );
          expect(
            cup.toTeaspoon(),
            const Volume.teaspoon(teaspoonPerCup),
          );
        },
      );

      test(
        'Convert to tablespoon',
        () {
          expect(
            cubicCentimeter.toTablespoon(),
            const Volume.tablespoon(tablespoonPerCubicCentimeter),
          );
          expect(
            milliliter.toTablespoon(),
            const Volume.tablespoon(tablespoonPerMilliliter),
          );
          expect(
            liter.toTablespoon(),
            const Volume.tablespoon(tablespoonPerLiter),
          );
          expect(
            teaspoon.toTablespoon(),
            const Volume.tablespoon(tablespoonPerTeaspoon),
          );
          expect(
            tablespoon.toTablespoon(),
            const Volume.tablespoon(1.0),
          );
          expect(
            fluidOunce.toTablespoon(),
            const Volume.tablespoon(tablespoonPerFluidOunce),
          );
          expect(
            cup.toTablespoon(),
            const Volume.tablespoon(tablespoonPerCup),
          );
        },
      );

      test(
        'Convert to fluid ounce',
        () {
          expect(
            cubicCentimeter.toFluidOunce(),
            const Volume.fluidOunce(fluidOuncePerCubicCentimeter),
          );
          expect(
            milliliter.toFluidOunce(),
            const Volume.fluidOunce(fluidOuncePerMilliliter),
          );
          expect(
            liter.toFluidOunce(),
            const Volume.fluidOunce(fluidOuncePerLiter),
          );
          expect(
            teaspoon.toFluidOunce(),
            const Volume.fluidOunce(fluidOuncePerTeaspoon),
          );
          expect(
            tablespoon.toFluidOunce(),
            const Volume.fluidOunce(fluidOuncePerTablespoon),
          );
          expect(
            fluidOunce.toFluidOunce(),
            const Volume.fluidOunce(1.0),
          );
          expect(
            cup.toFluidOunce(),
            const Volume.fluidOunce(fluidOuncePerCup),
          );
        },
      );

      test(
        'Convert to cup',
        () {
          expect(
            cubicCentimeter.toCup(),
            const Volume.cup(cupPerCubicCentimeter),
          );
          expect(
            milliliter.toCup(),
            const Volume.cup(cupPerMilliliter),
          );
          expect(
            liter.toCup(),
            const Volume.cup(cupPerLiter),
          );
          expect(
            teaspoon.toCup(),
            const Volume.cup(cupPerTeaspoon),
          );
          expect(
            tablespoon.toCup(),
            const Volume.cup(cupPerTablespoon),
          );
          expect(
            fluidOunce.toCup(),
            const Volume.cup(cupPerFluidOunce),
          );
          expect(
            cup.toCup(),
            const Volume.cup(1.0),
          );
        },
      );
    },
  );
}
