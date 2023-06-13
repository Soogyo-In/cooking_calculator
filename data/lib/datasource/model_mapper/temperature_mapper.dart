part of 'model_mapper.dart';

extension DataTemperatureMapper on Temperature {
  domain.Temperature toDomainModel() {
    if (unit.isCelsius) return domain.Celsius(value);
    if (unit.isFahrenheit) return domain.Fahrenheit(value);
    throw StateError('Unsupported type $runtimeType');
  }
}

extension DomainTemperatureMapper on domain.Temperature {
  Temperature toDataModel() {
    TemperatureUnit? unit;
    if (this is domain.Fahrenheit) unit = TemperatureUnit.fahrenheit;
    if (this is domain.Celsius) unit = TemperatureUnit.celsius;
    if (unit == null) throw StateError('Unsupported type $runtimeType');

    return Temperature(unit: unit, value: value);
  }
}
