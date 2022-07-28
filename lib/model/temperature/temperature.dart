import 'celsius.dart';
import 'fahrenheit.dart';

export 'celsius.dart';
export 'fahrenheit.dart';

abstract class Temperature {
  const Temperature();

  double get degree;

  Temperature operator +(covariant Temperature other);

  Temperature operator -(covariant Temperature other);

  Temperature operator *(num value);

  Temperature operator /(num divisor);

  String toStringAsFixed(int fractionDigits);

  Celsius toCelsius();

  Fahrenheit toFahrenheit();
}
