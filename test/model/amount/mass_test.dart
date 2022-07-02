import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get abbreviation of mass unit',
    () {
      expect(Milligram.abbr, 'mg');
      expect(Gram.abbr, 'g');
      expect(Kilogram.abbr, 'kg');
      expect(Ounce.abbr, 'oz');
      expect(Pound.abbr, 'lb');

      expect(Milligram(0.0).abbreviation, 'mg');
      expect(Gram(0.0).abbreviation, 'g');
      expect(Kilogram(0.0).abbreviation, 'kg');
      expect(Ounce(0.0).abbreviation, 'oz');
      expect(Pound(0.0).abbreviation, 'lb');
    },
  );

  group(
    '[Arithmetic operation]',
    () {
      test(
        'Addition',
        () {
          // Milligram
          expect(
            Milligram(1.0) + Milligram(1.0),
            Milligram(2.0),
          );
          expect(
            Milligram(1.0) + Gram(1.0),
            Milligram(1.0 + milligramPerGram),
          );
          expect(
            Milligram(1.0) + Kilogram(1.0),
            Milligram(1.0 + milligramPerKilogram),
          );
          expect(
            Milligram(1.0) + Ounce(1.0),
            Milligram(1.0 + milligramPerOunce),
          );
          expect(
            Milligram(1.0) + Pound(1.0),
            Milligram(1.0 + milligramPerPound),
          );

          // Gram
          expect(
            Gram(1.0) + Milligram(1.0),
            Gram(1.0 + gramPerMilligram),
          );
          expect(
            Gram(1.0) + Gram(1.0),
            Gram(2.0),
          );
          expect(
            Gram(1.0) + Kilogram(1.0),
            Gram(1.0 + gramPerKilogram),
          );
          expect(
            Gram(1.0) + Ounce(1.0),
            Gram(1.0 + gramPerOunce),
          );
          expect(
            Gram(1.0) + Pound(1.0),
            Gram(1.0 + gramPerPound),
          );

          // Kilogram
          expect(
            Kilogram(1.0) + Milligram(1.0),
            Kilogram(1.0 + kilogramPerMilligram),
          );
          expect(
            Kilogram(1.0) + Gram(1.0),
            Kilogram(1.0 + kilogramPerGram),
          );
          expect(
            Kilogram(1.0) + Kilogram(1.0),
            Kilogram(2.0),
          );
          expect(
            Kilogram(1.0) + Ounce(1.0),
            Kilogram(1.0 + kilogramPerOunce),
          );
          expect(
            Kilogram(1.0) + Pound(1.0),
            Kilogram(1.0 + kilogramPerPound),
          );

          // Ounce
          expect(
            Ounce(1.0) + Milligram(1.0),
            Ounce(1.0 + ouncePerMilligram),
          );
          expect(
            Ounce(1.0) + Gram(1.0),
            Ounce(1.0 + ouncePerGram),
          );
          expect(
            Ounce(1.0) + Kilogram(1.0),
            Ounce(1.0 + ouncePerKilogram),
          );
          expect(
            Ounce(1.0) + Ounce(1.0),
            Ounce(2.0),
          );
          expect(
            Ounce(1.0) + Pound(1.0),
            Ounce(1.0 + ouncePerPound),
          );

          // Pound
          expect(
            Pound(1.0) + Milligram(1.0),
            Pound(1.0 + poundPerMilligram),
          );
          expect(
            Pound(1.0) + Gram(1.0),
            Pound(1.0 + poundPerGram),
          );
          expect(
            Pound(1.0) + Kilogram(1.0),
            Pound(1.0 + poundPerKilogram),
          );
          expect(
            Pound(1.0) + Ounce(1.0),
            Pound(1.0 + poundPerOunce),
          );
          expect(
            Pound(1.0) + Pound(1.0),
            Pound(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          // Milligram
          expect(
            Milligram(1.0) - Milligram(1.0),
            Milligram(0.0),
          );
          expect(
            Milligram(1.0) - Gram(1.0),
            Milligram(1.0 - milligramPerGram),
          );
          expect(
            Milligram(1.0) - Kilogram(1.0),
            Milligram(1.0 - milligramPerKilogram),
          );
          expect(
            Milligram(1.0) - Ounce(1.0),
            Milligram(1.0 - milligramPerOunce),
          );
          expect(
            Milligram(1.0) - Pound(1.0),
            Milligram(1.0 - milligramPerPound),
          );

          // Gram
          expect(
            Gram(1.0) - Milligram(1.0),
            Gram(1.0 - gramPerMilligram),
          );
          expect(
            Gram(1.0) - Gram(1.0),
            Gram(0.0),
          );
          expect(
            Gram(1.0) - Kilogram(1.0),
            Gram(1.0 - gramPerKilogram),
          );
          expect(
            Gram(1.0) - Ounce(1.0),
            Gram(1.0 - gramPerOunce),
          );
          expect(
            Gram(1.0) - Pound(1.0),
            Gram(1.0 - gramPerPound),
          );

          // Kilogram
          expect(
            Kilogram(1.0) - Milligram(1.0),
            Kilogram(1.0 - kilogramPerMilligram),
          );
          expect(
            Kilogram(1.0) - Gram(1.0),
            Kilogram(1.0 - kilogramPerGram),
          );
          expect(
            Kilogram(1.0) - Kilogram(1.0),
            Kilogram(0.0),
          );
          expect(
            Kilogram(1.0) - Ounce(1.0),
            Kilogram(1.0 - kilogramPerOunce),
          );
          expect(
            Kilogram(1.0) - Pound(1.0),
            Kilogram(1.0 - kilogramPerPound),
          );

          // Ounce
          expect(
            Ounce(1.0) - Milligram(1.0),
            Ounce(1.0 - ouncePerMilligram),
          );
          expect(
            Ounce(1.0) - Gram(1.0),
            Ounce(1.0 - ouncePerGram),
          );
          expect(
            Ounce(1.0) - Kilogram(1.0),
            Ounce(1.0 - ouncePerKilogram),
          );
          expect(
            Ounce(1.0) - Ounce(1.0),
            Ounce(0.0),
          );
          expect(
            Ounce(1.0) - Pound(1.0),
            Ounce(1.0 - ouncePerPound),
          );

          // Pound
          expect(
            Pound(1.0) - Milligram(1.0),
            Pound(1.0 - poundPerMilligram),
          );
          expect(
            Pound(1.0) - Gram(1.0),
            Pound(1.0 - poundPerGram),
          );
          expect(
            Pound(1.0) - Kilogram(1.0),
            Pound(1.0 - poundPerKilogram),
          );
          expect(
            Pound(1.0) - Ounce(1.0),
            Pound(1.0 - poundPerOunce),
          );
          expect(
            Pound(1.0) - Pound(1.0),
            Pound(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(Milligram(1.0) * 2, Milligram(2.0));
          expect(Gram(1.0) * 2, Gram(2.0));
          expect(Kilogram(1.0) * 2, Kilogram(2.0));
          expect(Ounce(1.0) * 2, Ounce(2.0));
          expect(Pound(1.0) * 2, Pound(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(Milligram(2.0) / 2, Milligram(1.0));
          expect(Gram(2.0) / 2, Gram(1.0));
          expect(Kilogram(2.0) / 2, Kilogram(1.0));
          expect(Ounce(2.0) / 2, Ounce(1.0));
          expect(Pound(2.0) / 2, Pound(1.0));
        },
      );
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
