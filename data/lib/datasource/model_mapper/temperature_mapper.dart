part of 'model_mapper.dart';

extension TemperatureMapper on Temperature {
  TemperatureData toTemperatureData() {
    TemperatureUnit? unit;
    if (this is Fahrenheit) unit = TemperatureUnit.fahrenheit;
    if (this is Celsius) unit = TemperatureUnit.celsius;
    if (unit == null) throw StateError('Unsupported type $runtimeType');

    return TemperatureData()
      ..unit = unit
      ..value = value;
  }
}
