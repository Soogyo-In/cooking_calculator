import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group(
    '[Unit provider]',
    () {
      test(
        'Mass unit provider',
        () {
          final override = massUnitProvider
              .overrideWithValue(StateController(MassUnit.kilogram));
          override;
        },
      );

      test(
        'Volume unit provider',
        () {},
      );
    },
  );
}
