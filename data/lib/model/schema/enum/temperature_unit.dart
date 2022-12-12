import 'package:domain/domain.dart' as domain;

enum TemperatureUnit {
  celsius,
  fahrenheit;

  static fromTemperature(domain.Temperature temperature) {
    if (temperature is domain.Fahrenheit) return fahrenheit;
    if (temperature is domain.Celsius) return celsius;
    throw ArgumentError.value(
      temperature,
      'temperature',
      'Unsupported type ${temperature.runtimeType}',
    );
  }

  bool get isCelsius => this == celsius;
  bool get isFahrenheit => this == fahrenheit;
}
