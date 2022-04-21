import 'package:flutter/foundation.dart';
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
    final unit = json['unit'];

    final isMassUnit =
        MassUnit.values.map((massUnit) => massUnit.name).contains(unit);
    if (isMassUnit) return Mass.fromJson(json);

    final isVolumeUnit =
        VolumeUnit.values.map((volumeUnit) => volumeUnit.name).contains(unit);
    if (isVolumeUnit) return Volume.fromJson(json);

    throw ArgumentError.value(
      unit,
      'unit',
      'No unit enum value with that name',
    );
  }

  @override
  Map<String, dynamic> toJson(Amount object) {
    if (object is Mass) return object.toJson();
    if (object is Volume) return object.toJson();
    throw TypeError();
  }
}
