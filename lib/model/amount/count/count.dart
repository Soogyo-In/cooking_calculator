import 'package:cooking_calulator/model/amount/amount.dart';
import 'package:cooking_calulator/model/util/util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'count.freezed.dart';

@freezed
class Count with _$Count implements Amount {
  static const symbol = 'pcs';

  const Count._();

  const factory Count(double value) = _Count;

  @override
  Count operator *(num value) => Count(this.value * value);

  @override
  Count operator /(num divisor) => Count(value / divisor);

  @override
  Count operator +(covariant Count other) => Count(value + other.value);

  @override
  Count operator -(covariant Count other) => Count(value - other.value);

  @override
  String toZeroBoundedStringAsFixed(int fractionDigits) =>
      '${value.toZeroBoundedStringAsFixed(fractionDigits)} $symbol';
}
