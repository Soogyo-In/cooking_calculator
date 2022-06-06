import 'package:flutter_test/flutter_test.dart';
import 'package:cooking_calulator/util/extensions.dart';

void main() {
  test(
    'Round to double value to given decimal places',
    () {
      expect(DoubleExtension(0.5).round(), 1.0);
      expect(DoubleExtension(0.9).round(), 1.0);
      expect(DoubleExtension(1.0).round(), 1.0);
      expect(DoubleExtension(1.1).round(), 1.0);
      expect(DoubleExtension(1.4).round(), 1.0);
      expect(DoubleExtension(0.05).round(1), 0.1);
      expect(DoubleExtension(0.09).round(1), 0.1);
      expect(DoubleExtension(0.10).round(1), 0.1);
      expect(DoubleExtension(0.11).round(1), 0.1);
      expect(DoubleExtension(0.14).round(1), 0.1);
      expect(DoubleExtension(0.005).round(1), 0.0);
      expect(DoubleExtension(0.009).round(1), 0.0);
      expect(DoubleExtension(0.010).round(1), 0.0);
      expect(DoubleExtension(0.011).round(1), 0.0);
      expect(DoubleExtension(0.014).round(1), 0.0);
      expect(DoubleExtension(0.005).round(2), 0.01);
      expect(DoubleExtension(0.009).round(2), 0.01);
      expect(DoubleExtension(0.010).round(2), 0.01);
      expect(DoubleExtension(0.011).round(2), 0.01);
      expect(DoubleExtension(0.014).round(2), 0.01);
    },
  );
}
