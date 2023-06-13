part of 'temperature.dart';

const fahrenheitSymbol = '°F';

final class Fahrenheit extends Temperature {
  Fahrenheit(double value)
      : super(
          symbol: fahrenheitSymbol,
          value: value,
        );

  @override
  Celsius toCelsius() => Celsius((value - 32) * 5 / 9);

  @override
  Fahrenheit toFahrenheit() => Fahrenheit(value);

  @override
  Fahrenheit operator +(Temperature other) =>
      Fahrenheit(value + other.toFahrenheit().value);

  @override
  Fahrenheit operator -(Temperature other) =>
      Fahrenheit(value - other.toFahrenheit().value);

  @override
  Fahrenheit operator *(num factor) => Fahrenheit(value * factor);

  @override
  Fahrenheit operator /(num divisor) => Fahrenheit(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
