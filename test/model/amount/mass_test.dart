import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get abbreviation of mass unit',
    () {
      expect(Milligram.abbreviation, 'mg');
      expect(Gram.abbreviation, 'g');
      expect(Kilogram.abbreviation, 'kg');
      expect(Ounce.abbreviation, 'oz');
      expect(Pound.abbreviation, 'lb');
    },
  );

  test(
    'String expression',
    () {
      expect(const Milligram(1.5).toString(), '1.5 mg');
      expect(const Gram(1.5).toString(), '1.5 g');
      expect(const Kilogram(1.5).toString(), '1.5 kg');
      expect(const Ounce(1.5).toString(), '1.5 oz');
      expect(const Pound(1.5).toString(), '1.5 lb');
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
            const Milligram(1.0) + const Milligram(1.0),
            const Milligram(2.0),
          );
          expect(
            const Milligram(1.0) + const Gram(1.0),
            const Milligram(1.0 + milligramPerGram),
          );
          expect(
            const Milligram(1.0) + const Kilogram(1.0),
            const Milligram(1.0 + milligramPerKilogram),
          );
          expect(
            const Milligram(1.0) + const Ounce(1.0),
            const Milligram(1.0 + milligramPerOunce),
          );
          expect(
            const Milligram(1.0) + const Pound(1.0),
            const Milligram(1.0 + milligramPerPound),
          );

          // Gram
          expect(
            const Gram(1.0) + const Milligram(1.0),
            const Gram(1.0 + gramPerMilligram),
          );
          expect(
            const Gram(1.0) + const Gram(1.0),
            const Gram(2.0),
          );
          expect(
            const Gram(1.0) + const Kilogram(1.0),
            const Gram(1.0 + gramPerKilogram),
          );
          expect(
            const Gram(1.0) + const Ounce(1.0),
            const Gram(1.0 + gramPerOunce),
          );
          expect(
            const Gram(1.0) + const Pound(1.0),
            const Gram(1.0 + gramPerPound),
          );

          // Kilogram
          expect(
            const Kilogram(1.0) + const Milligram(1.0),
            const Kilogram(1.0 + kilogramPerMilligram),
          );
          expect(
            const Kilogram(1.0) + const Gram(1.0),
            const Kilogram(1.0 + kilogramPerGram),
          );
          expect(
            const Kilogram(1.0) + const Kilogram(1.0),
            const Kilogram(2.0),
          );
          expect(
            const Kilogram(1.0) + const Ounce(1.0),
            const Kilogram(1.0 + kilogramPerOunce),
          );
          expect(
            const Kilogram(1.0) + const Pound(1.0),
            const Kilogram(1.0 + kilogramPerPound),
          );

          // Ounce
          expect(
            const Ounce(1.0) + const Milligram(1.0),
            const Ounce(1.0 + ouncePerMilligram),
          );
          expect(
            const Ounce(1.0) + const Gram(1.0),
            const Ounce(1.0 + ouncePerGram),
          );
          expect(
            const Ounce(1.0) + const Kilogram(1.0),
            const Ounce(1.0 + ouncePerKilogram),
          );
          expect(
            const Ounce(1.0) + const Ounce(1.0),
            const Ounce(2.0),
          );
          expect(
            const Ounce(1.0) + const Pound(1.0),
            const Ounce(1.0 + ouncePerPound),
          );

          // Pound
          expect(
            const Pound(1.0) + const Milligram(1.0),
            const Pound(1.0 + poundPerMilligram),
          );
          expect(
            const Pound(1.0) + const Gram(1.0),
            const Pound(1.0 + poundPerGram),
          );
          expect(
            const Pound(1.0) + const Kilogram(1.0),
            const Pound(1.0 + poundPerKilogram),
          );
          expect(
            const Pound(1.0) + const Ounce(1.0),
            const Pound(1.0 + poundPerOunce),
          );
          expect(
            const Pound(1.0) + const Pound(1.0),
            const Pound(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          // Milligram
          expect(
            const Milligram(1.0) - const Milligram(1.0),
            const Milligram(0.0),
          );
          expect(
            const Milligram(1.0) - const Gram(1.0),
            const Milligram(1.0 - milligramPerGram),
          );
          expect(
            const Milligram(1.0) - const Kilogram(1.0),
            const Milligram(1.0 - milligramPerKilogram),
          );
          expect(
            const Milligram(1.0) - const Ounce(1.0),
            const Milligram(1.0 - milligramPerOunce),
          );
          expect(
            const Milligram(1.0) - const Pound(1.0),
            const Milligram(1.0 - milligramPerPound),
          );

          // Gram
          expect(
            const Gram(1.0) - const Milligram(1.0),
            const Gram(1.0 - gramPerMilligram),
          );
          expect(
            const Gram(1.0) - const Gram(1.0),
            const Gram(0.0),
          );
          expect(
            const Gram(1.0) - const Kilogram(1.0),
            const Gram(1.0 - gramPerKilogram),
          );
          expect(
            const Gram(1.0) - const Ounce(1.0),
            const Gram(1.0 - gramPerOunce),
          );
          expect(
            const Gram(1.0) - const Pound(1.0),
            const Gram(1.0 - gramPerPound),
          );

          // Kilogram
          expect(
            const Kilogram(1.0) - const Milligram(1.0),
            const Kilogram(1.0 - kilogramPerMilligram),
          );
          expect(
            const Kilogram(1.0) - const Gram(1.0),
            const Kilogram(1.0 - kilogramPerGram),
          );
          expect(
            const Kilogram(1.0) - const Kilogram(1.0),
            const Kilogram(0.0),
          );
          expect(
            const Kilogram(1.0) - const Ounce(1.0),
            const Kilogram(1.0 - kilogramPerOunce),
          );
          expect(
            const Kilogram(1.0) - const Pound(1.0),
            const Kilogram(1.0 - kilogramPerPound),
          );

          // Ounce
          expect(
            const Ounce(1.0) - const Milligram(1.0),
            const Ounce(1.0 - ouncePerMilligram),
          );
          expect(
            const Ounce(1.0) - const Gram(1.0),
            const Ounce(1.0 - ouncePerGram),
          );
          expect(
            const Ounce(1.0) - const Kilogram(1.0),
            const Ounce(1.0 - ouncePerKilogram),
          );
          expect(
            const Ounce(1.0) - const Ounce(1.0),
            const Ounce(0.0),
          );
          expect(
            const Ounce(1.0) - const Pound(1.0),
            const Ounce(1.0 - ouncePerPound),
          );

          // Pound
          expect(
            const Pound(1.0) - const Milligram(1.0),
            const Pound(1.0 - poundPerMilligram),
          );
          expect(
            const Pound(1.0) - const Gram(1.0),
            const Pound(1.0 - poundPerGram),
          );
          expect(
            const Pound(1.0) - const Kilogram(1.0),
            const Pound(1.0 - poundPerKilogram),
          );
          expect(
            const Pound(1.0) - const Ounce(1.0),
            const Pound(1.0 - poundPerOunce),
          );
          expect(
            const Pound(1.0) - const Pound(1.0),
            const Pound(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(const Milligram(1.0) * 2, const Milligram(2.0));
          expect(const Gram(1.0) * 2, const Gram(2.0));
          expect(const Kilogram(1.0) * 2, const Kilogram(2.0));
          expect(const Ounce(1.0) * 2, const Ounce(2.0));
          expect(const Pound(1.0) * 2, const Pound(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(const Milligram(2.0) / 2, const Milligram(1.0));
          expect(const Gram(2.0) / 2, const Gram(1.0));
          expect(const Kilogram(2.0) / 2, const Kilogram(1.0));
          expect(const Ounce(2.0) / 2, const Ounce(1.0));
          expect(const Pound(2.0) / 2, const Pound(1.0));
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
