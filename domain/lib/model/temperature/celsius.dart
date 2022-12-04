import 'package:freezed_annotation/freezed_annotation.dart';

import 'temperature.dart';

part 'celsius.freezed.dart';

@freezed
class Celsius with _$Celsius implements Temperature {
  static const symbol = '°C';

  const Celsius._();

  const factory Celsius(double degree) = _Celsius;

  @override
  Celsius toCelsius() => this;

  @override
  Fahrenheit toFahrenheit() => Fahrenheit(degree * 9 / 5 + 32);

  @override
  Celsius operator +(Temperature other) =>
      Celsius(degree + other.toCelsius().degree);

  @override
  Celsius operator -(Temperature other) =>
      Celsius(degree - other.toCelsius().degree);

  @override
  Celsius operator *(num factors) => Celsius(degree * factors.toDouble());

  @override
  Celsius operator /(num divisor) => Celsius(degree / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${degree.toStringAsFixed(fractionDigits)} $symbol';
}
