import 'package:cooking_calulator/model/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Value of Amount can be expressed as a string with symbol. If value can be Integer, omit decimal point.',
    () {
      expect(const Count(1.5).toStringWithSymbol(), '1.5 pcs');
      expect(const Count(1.0).toStringWithSymbol(), '1 pcs');
    },
  );
}
