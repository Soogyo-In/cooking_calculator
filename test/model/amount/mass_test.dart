import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get abbreviation of mass unit',
    () {
      expect(MassUnit.milligram.abbreviation, 'mg');
      expect(MassUnit.gram.abbreviation, 'g');
      expect(MassUnit.kilogram.abbreviation, 'kg');
      expect(MassUnit.ounce.abbreviation, 'oz');
      expect(MassUnit.pound.abbreviation, 'lb');
    },
  );

  group(
    '[Convert mass unit]',
    () {
      late Mass milligram;
      late Mass gram;
      late Mass kilogram;
      late Mass ounce;
      late Mass pound;

      setUp(() {
        milligram = Mass.milligram(1.0);
        gram = Mass.gram(1.0);
        kilogram = Mass.kilogram(1.0);
        ounce = Mass.ounce(1.0);
        pound = Mass.pound(1.0);
      });

      test(
        'Convert to milligram',
        () {
          expect(
            milligram.toMilligram(),
            Mass.milligram(1.0),
          );
          expect(
            gram.toMilligram(),
            Mass.milligram(milligramPerGram),
          );
          expect(
            kilogram.toMilligram(),
            Mass.milligram(milligramPerKilogram),
          );
          expect(
            ounce.toMilligram(),
            Mass.milligram(milligramPerOunce),
          );
          expect(
            pound.toMilligram(),
            Mass.milligram(milligramPerPound),
          );
        },
      );

      test(
        'Convert to gram',
        () {
          expect(
            milligram.toGram(),
            Mass.gram(gramPerMilligram),
          );
          expect(
            gram.toGram(),
            Mass.gram(1.0),
          );
          expect(
            kilogram.toGram(),
            Mass.gram(gramPerKilogram),
          );
          expect(
            ounce.toGram(),
            Mass.gram(gramPerOunce),
          );
          expect(
            pound.toGram(),
            Mass.gram(gramPerPound),
          );
        },
      );

      test(
        'Convert to kilogram',
        () {
          expect(
            milligram.toKilogram(),
            Mass.kilogram(kilogramPerMilligram),
          );
          expect(
            gram.toKilogram(),
            Mass.kilogram(kilogramPerGram),
          );
          expect(
            kilogram.toKilogram(),
            Mass.kilogram(1.0),
          );
          expect(
            ounce.toKilogram(),
            Mass.kilogram(kilogramPerOunce),
          );
          expect(
            pound.toKilogram(),
            Mass.kilogram(kilogramPerPound),
          );
        },
      );

      test(
        'Convert to ounce',
        () {
          expect(
            milligram.toOunce(),
            Mass.ounce(ouncePerMilligram),
          );
          expect(
            gram.toOunce(),
            Mass.ounce(ouncePerGram),
          );
          expect(
            kilogram.toOunce(),
            Mass.ounce(ouncePerKilogram),
          );
          expect(
            ounce.toOunce(),
            Mass.ounce(1.0),
          );
          expect(
            pound.toOunce(),
            Mass.ounce(ouncePerPound),
          );
        },
      );

      test(
        'Convert to pound',
        () {
          expect(
            milligram.toPound(),
            Mass.pound(poundPerMilligram),
          );
          expect(
            gram.toPound(),
            Mass.pound(poundPerGram),
          );
          expect(
            kilogram.toPound(),
            Mass.pound(poundPerKilogram),
          );
          expect(
            ounce.toPound(),
            Mass.pound(poundPerOunce),
          );
          expect(
            pound.toPound(),
            Mass.pound(1.0),
          );
        },
      );
    },
  );
}
