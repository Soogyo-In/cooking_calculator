part of 'temperature.dart';

const celsiusSymbol = '°C';

final class Celsius extends Temperature {
  Celsius(double value)
      : super(
          symbol: celsiusSymbol,
          value: value,
        );

  @override
  Celsius toCelsius() => Celsius(value);

  @override
  Fahrenheit toFahrenheit() => Fahrenheit(value * 9 / 5 + 32);

  @override
  Celsius operator +(Temperature other) =>
      Celsius(value + other.toCelsius().value);

  @override
  Celsius operator -(Temperature other) =>
      Celsius(value - other.toCelsius().value);

  @override
  Celsius operator *(num factor) => Celsius(value * factor);

  @override
  Celsius operator /(num divisor) => Celsius(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
