import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get symbol of count unit',
    () {
      expect(Count.symbol, 'pcs');
    },
  );

  test(
    'String expression',
    () {
      expect(const Count(1.555).toZeroBoundedStringAsFixed(2), '1.56 pcs');
    },
  );

  group(
    '[Arithmetic operation]',
    () {
      test(
        'Addition',
        () {
          expect(
            const Count(1.0) + const Count(1.0),
            const Count(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          expect(
            const Count(1.0) - const Count(1.0),
            const Count(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(const Count(1.0) * 2, const Count(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(const Count(2.0) / 2, const Count(1.0));
        },
      );
    },
  );
}
