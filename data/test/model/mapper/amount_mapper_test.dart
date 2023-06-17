import 'package:data/model/model.dart';
import 'package:domain/model/amount/amount.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Can create MatterUnit from',
    () {
      test(
        'Milligram',
        () {
          expect(
            Milligram(0).toMatterUnit(),
            MatterUnit.milligram,
          );
        },
      );

      test(
        'Gram',
        () {
          expect(
            Gram(0.0).toMatterUnit(),
            MatterUnit.gram,
          );
        },
      );

      test(
        'Kilogram',
        () {
          expect(
            Kilogram(0.0).toMatterUnit(),
            MatterUnit.kilogram,
          );
        },
      );

      test(
        'Ounce',
        () {
          expect(
            Ounce(0.0).toMatterUnit(),
            MatterUnit.ounce,
          );
        },
      );

      test(
        'Pound',
        () {
          expect(
            Pound(0.0).toMatterUnit(),
            MatterUnit.pound,
          );
        },
      );

      test(
        'CubicCentimeter',
        () {
          expect(
            CubicCentimeter(0).toMatterUnit(),
            MatterUnit.cubicCentimeter,
          );
        },
      );

      test(
        'Milliliter',
        () {
          expect(
            Milliliter(0).toMatterUnit(),
            MatterUnit.milliliter,
          );
        },
      );

      test(
        'Liter',
        () {
          expect(
            Liter(0.0).toMatterUnit(),
            MatterUnit.liter,
          );
        },
      );

      test(
        'Teaspoon',
        () {
          expect(
            Teaspoon(0.0).toMatterUnit(),
            MatterUnit.teaspoon,
          );
        },
      );

      test(
        'Tablespoon',
        () {
          expect(
            Tablespoon(0.0).toMatterUnit(),
            MatterUnit.tablespoon,
          );
        },
      );

      test(
        'FluidOunce',
        () {
          expect(
            FluidOunce(0.0).toMatterUnit(),
            MatterUnit.fluidOunce,
          );
        },
      );

      test(
        'Cup',
        () {
          expect(
            Cup(0.0).toMatterUnit(),
            MatterUnit.cup,
          );
        },
      );

      test(
        'Count',
        () {
          expect(
            Count(0.0).toMatterUnit(),
            MatterUnit.count,
          );
        },
      );
    },
  );
}
