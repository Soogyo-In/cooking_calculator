import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount.freezed.dart';
part 'amount.g.dart';
part 'mass.dart';
part 'volume.dart';

class NegativeValueException implements Exception {}

abstract class Amount {
  const Amount();

  double get value;
}

class AmountJsonConverter
    implements JsonConverter<Amount, Map<String, dynamic>> {
  const AmountJsonConverter();

  @override
  Amount fromJson(Map<String, dynamic> json) {
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
    final abbreviation = json['abbreviation'];

    final isMassUnit = massUnitSet.contains(abbreviation);
    if (isMassUnit) return Mass.fromJson(json);

    final isVolumeUnit = volumeUnitSet.contains(abbreviation);
    if (isVolumeUnit) return Volume.fromJson(json);

    throw CheckedFromJsonException(
      json,
      'abbreviation',
      'Amount',
      'Unsupported amount unit: $abbreviation',
    );
  }

  @override
  Map<String, dynamic> toJson(Amount object) {
    if (object is Mass) return object.toJson();
    if (object is Volume) return object.toJson();

    throw JsonUnsupportedObjectError(object);
  }
}
