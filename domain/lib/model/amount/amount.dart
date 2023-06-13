import 'package:equatable/equatable.dart';

export 'count/count.dart';
export 'mass/mass.dart';
export 'volume/volume.dart';

abstract base class Amount extends Equatable implements Comparable<Amount> {
  const Amount({
    required this.value,
    required this.symbol,
  });

  final double value;

  final String symbol;

  Amount roundedAt(int fractionDigits);

  Amount operator +(covariant Amount other);

  Amount operator -(covariant Amount other);

  Amount operator *(num factor);

  Amount operator /(num divisor);

  bool operator <(covariant Amount other);

  bool operator >(covariant Amount other);

  bool operator <=(covariant Amount other);

  bool operator >=(covariant Amount other);

  @override
  List<Object?> get props => [value, symbol];
}

extension AmountStringifier on Amount {
  String toStringWithSymbol() =>
      value % 1.0 == 0.0 ? '${value.truncate()} $symbol' : '$value $symbol';
}
