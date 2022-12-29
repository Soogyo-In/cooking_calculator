import 'package:data/data.dart';
import 'package:domain/domain.dart';

extension TemperatureMapper on Temperature {
  TemperatureData toTemperature() {
    TemperatureUnit? unit;
    if (this is Fahrenheit) unit = TemperatureUnit.fahrenheit;
    if (this is Celsius) unit = TemperatureUnit.celsius;
    if (unit == null) throw StateError('Unsupported type $runtimeType');

    return TemperatureData()
      ..unit = unit
      ..value = value;
  }
}
