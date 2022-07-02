import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount.freezed.dart';
part 'mass.dart';
part 'volume.dart';

class NegativeValueException implements Exception {}

abstract class Amount {
  const Amount();

  double get value;

  Amount operator +(covariant Amount other);

  Amount operator -(covariant Amount other);

  Amount operator *(num value);

  Amount operator /(num divisor);
}
