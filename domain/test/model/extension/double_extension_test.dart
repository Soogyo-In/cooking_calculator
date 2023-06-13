import 'package:domain/model/extension/double_extenstion.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Round value at specified fraction digits',
    () {
      expect(1.006.roundAt(3), 1.01);
      expect(1.005.roundAt(3), 1.01);
      expect(1.004.roundAt(3), 1.00);
    },
  );
}
