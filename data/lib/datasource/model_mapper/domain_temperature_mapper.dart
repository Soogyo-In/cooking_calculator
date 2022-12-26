import 'package:data/data.dart';

import 'package:domain/domain.dart' as domain;

extension DomainTemperatureMapper on domain.Temperature {
  Temperature toTemperature() {
    TemperatureUnit? unit;
    if (this is domain.Fahrenheit) unit = TemperatureUnit.fahrenheit;
    if (this is domain.Celsius) unit = TemperatureUnit.celsius;
    if (unit == null) throw StateError('Unsupported type $runtimeType');

    return Temperature()
      ..unit = unit
      ..value = degree;
  }
}
