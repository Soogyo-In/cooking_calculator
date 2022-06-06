import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

void main() {
  group(
    '[Convert each other Amount and JSON]',
    () {
      const massUnitSet = {
        Milligram.abbr,
        Gram.abbr,
        Kilogram.abbr,
        Ounce.abbr,
        Pound.abbr,
      };
      const volumeUnitSet = {
        CubicCentimeter.abbr,
        Cup.abbr,
        FluidOunce.abbr,
        Liter.abbr,
        Milliliter.abbr,
        Tablespoon.abbr,
        Teaspoon.abbr,
      };
      final masses = [
        Milligram(0.0),
        Gram(0.0),
        Kilogram(0.0),
        Ounce(0.0),
        Pound(0.0),
      ];
      final volumes = [
        CubicCentimeter(0.0),
        Cup(0.0),
        FluidOunce(0.0),
        Liter(0.0),
        Milliliter(0.0),
        Tablespoon(0.0),
        Teaspoon(0.0),
      ];
      late AmountJsonConverter converter;

      setUp(() {
        converter = const AmountJsonConverter();
      });

      test(
        'Create Amount object from JSON',
        () {
          final actualMasses = massUnitSet.map(
            (unit) => converter.fromJson({
              'abbreviation': unit,
              'value': 0.0,
            }),
          );
          expect(actualMasses, masses);

          final actualVolumes = volumeUnitSet.map(
            (unit) => converter.fromJson({
              'abbreviation': unit,
              'value': 0.0,
            }),
          );
          expect(actualVolumes, volumes);

          final invalidJson = <String, dynamic>{
            'abbreviation': 'invalidUnit',
            'value': 1.0,
          };
          expect(
            () => converter.fromJson(invalidJson),
            throwsA(isA<CheckedFromJsonException>()),
          );
        },
      );

      test(
        'Conver Amount to JSON',
        () {
          final actualMassJsons = masses.map((mass) => mass.toJson());
          final matcherMassJsons = massUnitSet.map(
            (unit) => {'abbreviation': unit, 'value': 0.0},
          );
          expect(actualMassJsons, matcherMassJsons);

          final actualVolumeJsons = volumes.map((volume) => volume.toJson());
          final mathcerVolumeJsons = volumeUnitSet.map(
            (unit) => {'abbreviation': unit, 'value': 0.0},
          );
          expect(actualVolumeJsons, mathcerVolumeJsons);
        },
      );
    },
  );
}
