export 'count/count.dart';
export 'mass/mass.dart';
export 'volume/volume.dart';

abstract class Amount {
  const Amount();

  double get value;

  String get symbol;

  Amount roundedAt(int fractionDigits);

  Amount operator +(covariant Amount other);

  Amount operator -(covariant Amount other);

  Amount operator *(num value);

  Amount operator /(num divisor);
}

extension AmountStringifier on Amount {
  String toStringWithSymbol() =>
      value % 1.0 == 0.0 ? '${value.truncate()} $symbol' : '$value $symbol';
}
