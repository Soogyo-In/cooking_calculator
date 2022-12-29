import 'package:domain/model/model.dart';
import 'package:domain/model/util/util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'count.freezed.dart';

const countSymbol = 'pcs';

@freezed
class Count with _$Count implements Amount {
  @override
  final symbol = countSymbol;

  const Count._();

  const factory Count(double value) = _Count;

  @override
  Count roundedAt(int fractionDigits) => Count(value.roundAt(fractionDigits));

  @override
  Count operator *(num value) => Count(this.value * value);

  @override
  Count operator /(num divisor) => Count(value / divisor);

  @override
  Count operator +(covariant Count other) => Count(value + other.value);

  @override
  Count operator -(covariant Count other) => Count(value - other.value);
}
