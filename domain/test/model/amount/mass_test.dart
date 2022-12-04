import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Get symbol of mass unit',
    () {
      expect(milligramSymbol, 'mg');
      expect(gramSymbol, 'g');
      expect(kilogramSymbol, 'kg');
      expect(ounceSymbol, 'oz');
      expect(poundSymbol, 'lb');
    },
  );

  test(
    'Get Mass object rounded value at specified fraction digits',
    () {
      expect(const Milligram(1.55).roundedAt(2), const Milligram(1.6));
      expect(const Gram(1.55).roundedAt(2), const Gram(1.6));
      expect(const Kilogram(1.55).roundedAt(2), const Kilogram(1.6));
      expect(const Ounce(1.55).roundedAt(2), const Ounce(1.6));
      expect(const Pound(1.55).roundedAt(2), const Pound(1.6));
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
        milligram = const Mass.milligram(1.0);
        gram = const Mass.gram(1.0);
        kilogram = const Mass.kilogram(1.0);
        ounce = const Mass.ounce(1.0);
        pound = const Mass.pound(1.0);
      });

      test(
        'Convert to milligram',
        () {
          expect(
            milligram.toMilligram(),
            const Mass.milligram(1.0),
          );
          expect(
            gram.toMilligram(),
            const Mass.milligram(milligramPerGram),
          );
          expect(
            kilogram.toMilligram(),
            const Mass.milligram(milligramPerKilogram),
          );
          expect(
            ounce.toMilligram(),
            const Mass.milligram(milligramPerOunce),
          );
          expect(
            pound.toMilligram(),
            const Mass.milligram(milligramPerPound),
          );
        },
      );

      test(
        'Convert to gram',
        () {
          expect(
            milligram.toGram(),
            const Mass.gram(gramPerMilligram),
          );
          expect(
            gram.toGram(),
            const Mass.gram(1.0),
          );
          expect(
            kilogram.toGram(),
            const Mass.gram(gramPerKilogram),
          );
          expect(
            ounce.toGram(),
            const Mass.gram(gramPerOunce),
          );
          expect(
            pound.toGram(),
            const Mass.gram(gramPerPound),
          );
        },
      );

      test(
        'Convert to kilogram',
        () {
          expect(
            milligram.toKilogram(),
            const Mass.kilogram(kilogramPerMilligram),
          );
          expect(
            gram.toKilogram(),
            const Mass.kilogram(kilogramPerGram),
          );
          expect(
            kilogram.toKilogram(),
            const Mass.kilogram(1.0),
          );
          expect(
            ounce.toKilogram(),
            const Mass.kilogram(kilogramPerOunce),
          );
          expect(
            pound.toKilogram(),
            const Mass.kilogram(kilogramPerPound),
          );
        },
      );

      test(
        'Convert to ounce',
        () {
          expect(
            milligram.toOunce(),
            const Mass.ounce(ouncePerMilligram),
          );
          expect(
            gram.toOunce(),
            const Mass.ounce(ouncePerGram),
          );
          expect(
            kilogram.toOunce(),
            const Mass.ounce(ouncePerKilogram),
          );
          expect(
            ounce.toOunce(),
            const Mass.ounce(1.0),
          );
          expect(
            pound.toOunce(),
            const Mass.ounce(ouncePerPound),
          );
        },
      );

      test(
        'Convert to pound',
        () {
          expect(
            milligram.toPound(),
            const Mass.pound(poundPerMilligram),
          );
          expect(
            gram.toPound(),
            const Mass.pound(poundPerGram),
          );
          expect(
            kilogram.toPound(),
            const Mass.pound(poundPerKilogram),
          );
          expect(
            ounce.toPound(),
            const Mass.pound(poundPerOunce),
          );
          expect(
            pound.toPound(),
            const Mass.pound(1.0),
          );
        },
      );
    },
  );
}
