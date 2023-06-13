part of 'enum.dart';

enum TemperatureUnit {
  celsius,
  fahrenheit;

  bool get isCelsius => this == celsius;

  bool get isFahrenheit => this == fahrenheit;
}
