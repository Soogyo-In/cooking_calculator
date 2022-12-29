import 'package:freezed_annotation/freezed_annotation.dart';

import 'temperature.dart';

part 'fahrenheit.freezed.dart';

@freezed
class Fahrenheit with _$Fahrenheit implements Temperature {
  static const symbol = '°F';

  const Fahrenheit._();

  const factory Fahrenheit(double value) = _Fahrenheit;

  @override
  Celsius toCelsius() => Celsius((value - 32) * 5 / 9);

  @override
  Fahrenheit toFahrenheit() => this;

  @override
  Fahrenheit operator +(Temperature other) =>
      Fahrenheit(value + other.toFahrenheit().value);

  @override
  Fahrenheit operator -(Temperature other) =>
      Fahrenheit(value - other.toFahrenheit().value);

  @override
  Fahrenheit operator *(num factors) => Fahrenheit(value * factors.toDouble());

  @override
  Fahrenheit operator /(num divisor) => Fahrenheit(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
