import 'package:domain/model/extension/extension.dart';
import 'package:domain/model/model.dart';

const countSymbol = 'pcs';

final class Count extends Amount {
  Count(double value)
      : super(
          symbol: countSymbol,
          value: value,
        );

  @override
  Count roundedAt(int fractionDigits) => Count(value.roundAt(fractionDigits));

  @override
  Count operator *(num factor) => Count(value * factor);

  @override
  Count operator /(num divisor) => Count(value / divisor);

  @override
  Count operator +(Count other) => Count(value + other.value);

  @override
  Count operator -(Count other) => Count(value - other.value);

  @override
  bool operator <(Count other) => compareTo(other) < 0;

  @override
  bool operator <=(Count other) => compareTo(other) <= 0;

  @override
  bool operator >(Count other) => compareTo(other) > 0;

  @override
  bool operator >=(Count other) => compareTo(other) >= 0;

  @override
  int compareTo(Amount other) => value.compareTo(other.value);

  @override
  Count copyWith({covariant double? value}) => Count(value ?? this.value);
}
