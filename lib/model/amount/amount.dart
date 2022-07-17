export 'mass/mass.dart';
export 'volume/volume.dart';

class NegativeValueException implements Exception {}

abstract class Amount {
  const Amount();

  double get value;

  Amount operator +(covariant Amount other);

  Amount operator -(covariant Amount other);

  Amount operator *(num value);

  Amount operator /(num divisor);

  String toStringAsFixed(int fractionDigits);
}
