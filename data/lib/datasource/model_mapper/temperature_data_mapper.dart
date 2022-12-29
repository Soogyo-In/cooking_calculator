import 'package:data/data.dart';
import 'package:domain/domain.dart';

extension TemperatureDataMapper on TemperatureData {
  Temperature toDomainTemperature() {
    if (unit.isCelsius) return Celsius(value);
    if (unit.isFahrenheit) return Fahrenheit(value);
    throw StateError('Unsupported type $runtimeType');
  }
}
