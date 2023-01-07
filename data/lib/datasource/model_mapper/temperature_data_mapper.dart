part of 'model_mapper.dart';

extension TemperatureDataMapper on TemperatureData {
  Temperature toTemperature() {
    if (unit.isCelsius) return Celsius(value);
    if (unit.isFahrenheit) return Fahrenheit(value);
    throw StateError('Unsupported type $runtimeType');
  }
}
