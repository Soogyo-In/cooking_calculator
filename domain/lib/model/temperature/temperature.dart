import 'package:equatable/equatable.dart';

part 'celsius.dart';
part 'fahrenheit.dart';

abstract base class Temperature extends Equatable {
  Temperature({
    required this.value,
    required this.symbol,
  });

  factory Temperature.celsius(double value) = Celsius;

  factory Temperature.fahrenheit(double value) = Fahrenheit;

  final double value;

  final String symbol;

  @override
  List<Object?> get props => [value, symbol];

  Temperature operator +(covariant Temperature other);

  Temperature operator -(covariant Temperature other);

  Temperature operator *(num factor);

  Temperature operator /(num divisor);

  String toStringAsFixed(int fractionDigits);

  Celsius toCelsius();

  Fahrenheit toFahrenheit();
}
