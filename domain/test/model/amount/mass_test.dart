import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Get Mass object rounded value at specified fraction digits',
    () {
      expect(Milligram(1).roundedAt(2), Milligram(1));
      expect(Gram(1.55).roundedAt(2), Gram(1.6));
      expect(Kilogram(1.55).roundedAt(2), Kilogram(1.6));
      expect(Ounce(1.55).roundedAt(2), Ounce(1.6));
      expect(Pound(1.55).roundedAt(2), Pound(1.6));
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
            Milligram(1) + Milligram(1),
            Milligram(2),
          );
          expect(
            Milligram(1) + Gram(1.0),
            Milligram((1 + milligramPerGram).round()),
          );
          expect(
            Milligram(1) + Kilogram(1.0),
            Milligram((1 + milligramPerKilogram).round()),
          );
          expect(
            Milligram(1) + Ounce(1.0),
            Milligram((1 + milligramPerOunce).round()),
          );
          expect(
            Milligram(1) + Pound(1.0),
            Milligram((1 + milligramPerPound).round()),
          );

          // Gram
          expect(
            Gram(1.0) + Milligram(1),
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
            Kilogram(1.0) + Milligram(1),
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
            Ounce(1.0) + Milligram(1),
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
            Pound(1.0) + Milligram(1),
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
            Milligram(1) - Milligram(1),
            Milligram(0),
          );
          expect(
            Milligram(1) - Gram(1.0),
            Milligram((1 - milligramPerGram).round()),
          );
          expect(
            Milligram(1) - Kilogram(1.0),
            Milligram((1 - milligramPerKilogram).round()),
          );
          expect(
            Milligram(1) - Ounce(1.0),
            Milligram((1 - milligramPerOunce).round()),
          );
          expect(
            Milligram(1) - Pound(1.0),
            Milligram((1 - milligramPerPound).round()),
          );

          // Gram
          expect(
            Gram(1.0) - Milligram(1),
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
            Kilogram(1.0) - Milligram(1),
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
            Ounce(1.0) - Milligram(1),
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
            Pound(1.0) - Milligram(1),
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
          expect(Milligram(1) * 2, Milligram(2));
          expect(Gram(1.0) * 2, Gram(2.0));
          expect(Kilogram(1.0) * 2, Kilogram(2.0));
          expect(Ounce(1.0) * 2, Ounce(2.0));
          expect(Pound(1.0) * 2, Pound(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(Milligram(2) / 2, Milligram(1));
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
        milligram = Mass.milligram(1);
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
            Mass.milligram(1),
          );
          expect(
            gram.toMilligram(),
            Mass.milligram(milligramPerGram.round()),
          );
          expect(
            kilogram.toMilligram(),
            Mass.milligram(milligramPerKilogram.round()),
          );
          expect(
            ounce.toMilligram(),
            Mass.milligram(milligramPerOunce.round()),
          );
          expect(
            pound.toMilligram(),
            Mass.milligram(milligramPerPound.round()),
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
