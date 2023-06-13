import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Get Count object rounded value at specified fraction digits',
    () {
      expect(Count(1.55).roundedAt(2), Count(1.6));
    },
  );

  group(
    '[Arithmetic operation]',
    () {
      test(
        'Addition',
        () {
          expect(
            Count(1.0) + Count(1.0),
            Count(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          expect(
            Count(1.0) - Count(1.0),
            Count(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(Count(1.0) * 2, Count(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(Count(2.0) / 2, Count(1.0));
        },
      );
    },
  );
}
