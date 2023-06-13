import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'temperature.g.dart';

@Embedded(inheritance: false)
class Temperature extends Equatable {
  const Temperature({
    this.unit = TemperatureUnit.celsius,
    this.value = 0.0,
  });

  @enumerated
  final TemperatureUnit unit;

  final float value;

  @ignore
  @override
  List<Object?> get props => [
        unit,
        value,
      ];
}
