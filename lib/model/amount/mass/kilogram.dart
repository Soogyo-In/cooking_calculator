part of 'mass.dart';

@freezed
class Kilogram with _$Kilogram implements Mass {
  static const symbol = 'kg';

  const Kilogram._();

  const factory Kilogram(double value) = _Kilogram;

  @override
  Gram toGram() => Gram(gramPerKilogram * value);

  @override
  Kilogram toKilogram() => Kilogram(value);

  @override
  Milligram toMilligram() => Milligram(milligramPerKilogram * value);

  @override
  Ounce toOunce() => Ounce(ouncePerKilogram * value);

  @override
  Pound toPound() => Pound(poundPerKilogram * value);

  @override
  Kilogram operator +(Mass other) => Kilogram(value + other.toKilogram().value);

  @override
  Kilogram operator -(Mass other) => Kilogram(value - other.toKilogram().value);

  @override
  Kilogram operator *(num factors) => Kilogram(value * factors.toDouble());

  @override
  Kilogram operator /(num divisor) => Kilogram(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $symbol';
}
