import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '[Convert each other Amount and JSON]',
    () {
      late AmountJsonConverter converter;

      setUp(() {
        converter = const AmountJsonConverter();
      });

      test(
        'Create Amount object from JSON',
        () {
          final actualMasses = MassUnit.values.map(
            (unit) => converter.fromJson({
              'unit': unit.name,
              'value': 1.0,
            }),
          );
          final matcherMasses = MassUnit.values.map(
            (unit) => Mass(1.0, unit),
          );
          expect(actualMasses, matcherMasses);

          final actualVolumes = VolumeUnit.values.map(
            (unit) => converter.fromJson({
              'unit': unit.name,
              'value': 1.0,
            }),
          );
          final matcherVolumes = VolumeUnit.values.map(
            (unit) => Volume(1.0, unit),
          );
          expect(actualVolumes, matcherVolumes);

          final invalidJson = <String, dynamic>{
            'unit': 'invalidUnit',
            'value': 1.0,
          };
          expect(
            () => converter.fromJson(invalidJson),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test(
        'Conver Amount to JSON',
        () {
          final actualMassJsons = MassUnit.values.map(
            (unit) => Mass(1.0, unit).toJson(),
          );
          final matcherMassJsons = MassUnit.values.map(
            (unit) => {
              'unit': unit.name,
              'value': 1.0,
            },
          );
          expect(actualMassJsons, matcherMassJsons);

          final actualVolumeJsons = VolumeUnit.values.map(
            (unit) => Volume(1.0, unit).toJson(),
          );
          final mathcerVolumeJsons = VolumeUnit.values.map(
            (unit) => {
              'unit': unit.name,
              'value': 1.0,
            },
          );
          expect(actualVolumeJsons, mathcerVolumeJsons);
        },
      );
    },
  );
}
