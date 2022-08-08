import 'package:cooking_calulator/model/util/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Parse zero bounded string as fixed',
    () {
      expect(0.006.toZeroBoundedStringAsFixed(2), '0.01');
      expect(0.005.toZeroBoundedStringAsFixed(2), '0.01');
      expect(0.004.toZeroBoundedStringAsFixed(2), '0.01');
    },
  );
}
