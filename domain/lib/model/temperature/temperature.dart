import 'celsius.dart';
import 'fahrenheit.dart';

export 'celsius.dart';
export 'fahrenheit.dart';

abstract class Temperature {
  const Temperature();

  const factory Temperature.celsius(double degree) = Celsius;

  const factory Temperature.fahrenheit(double degree) = Fahrenheit;

  double get degree;

  Temperature operator +(covariant Temperature other);

  Temperature operator -(covariant Temperature other);

  Temperature operator *(num value);

  Temperature operator /(num divisor);

  String toStringAsFixed(int fractionDigits);

  Celsius toCelsius();

  Fahrenheit toFahrenheit();
}
