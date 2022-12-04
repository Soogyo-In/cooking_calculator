import 'package:freezed_annotation/freezed_annotation.dart';

import 'temperature.dart';

part 'fahrenheit.freezed.dart';

@freezed
class Fahrenheit with _$Fahrenheit implements Temperature {
  static const symbol = '°F';

  const Fahrenheit._();

  const factory Fahrenheit(double degree) = _Fahrenheit;

  @override
  Celsius toCelsius() => Celsius((degree - 32) * 5 / 9);

  @override
  Fahrenheit toFahrenheit() => this;

  @override
  Fahrenheit operator +(Temperature other) =>
      Fahrenheit(degree + other.toFahrenheit().degree);

  @override
  Fahrenheit operator -(Temperature other) =>
      Fahrenheit(degree - other.toFahrenheit().degree);

  @override
  Fahrenheit operator *(num factors) => Fahrenheit(degree * factors.toDouble());

  @override
  Fahrenheit operator /(num divisor) => Fahrenheit(degree / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${degree.toStringAsFixed(fractionDigits)} $symbol';
}
