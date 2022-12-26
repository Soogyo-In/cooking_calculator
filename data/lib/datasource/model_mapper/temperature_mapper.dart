import 'package:data/data.dart';

import 'package:domain/domain.dart' as domain;

extension TemperatureMapper on Temperature {
  domain.Temperature toDomainTemperature() {
    if (unit.isCelsius) return domain.Celsius(value);
    if (unit.isFahrenheit) return domain.Fahrenheit(value);
    throw StateError('Unsupported type $runtimeType');
  }
}
