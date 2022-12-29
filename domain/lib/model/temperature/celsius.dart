import 'package:freezed_annotation/freezed_annotation.dart';

import 'temperature.dart';

part 'celsius.freezed.dart';

@freezed
class Celsius with _$Celsius implements Temperature {
  static const symbol = '°C';

  const Celsius._();

  const factory Celsius(double value) = _Celsius;

  @override
  Celsius toCelsius() => this;

  @override
  Fahrenheit toFahrenheit() => Fahrenheit(value * 9 / 5 + 32);

  @override
  Celsius operator +(Temperature other) =>
      Celsius(value + other.toCelsius().value);

  @override
  Celsius operator -(Temperature other) =>
      Celsius(value - other.toCelsius().value);

  @override
  Celsius operator *(num factors) => Celsius(value * factors.toDouble());

  @override
  Celsius operator /(num divisor) => Celsius(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
