part of 'mass.dart';

@freezed
class Kilogram with _$Kilogram implements Mass {
  @override
  final symbol = kilogramSymbol;

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
  Kilogram roundedAt(int fractionDigits) =>
      Kilogram(value.roundAt(fractionDigits));

  @override
  Kilogram operator +(Mass other) => Kilogram(value + other.toKilogram().value);

  @override
  Kilogram operator -(Mass other) => Kilogram(value - other.toKilogram().value);

  @override
  Kilogram operator *(num factors) => Kilogram(value * factors.toDouble());

  @override
  Kilogram operator /(num divisor) => Kilogram(value / divisor);
}
