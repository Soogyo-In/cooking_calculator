import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Get symbol of count unit',
    () {
      expect(countSymbol, 'pcs');
    },
  );

  test(
    'Get Count object rounded value at specified fraction digits',
    () {
      expect(const Count(1.55).roundedAt(2), const Count(1.6));
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
