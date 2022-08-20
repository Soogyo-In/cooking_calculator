part of 'mass.dart';

@freezed
class Pound with _$Pound implements Mass {
  @override
  final symbol = poundSymbol;

  const Pound._();

  const factory Pound(double value) = _Pound;

  @override
  Gram toGram() => Gram(gramPerPound * value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerPound * value);

  @override
  Milligram toMilligram() => Milligram(milligramPerPound * value);

  @override
  Ounce toOunce() => Ounce(ouncePerPound * value);

  @override
  Pound toPound() => Pound(value);

  @override
  Pound roundedAt(int fractionDigits) => Pound(value.roundAt(fractionDigits));

  @override
  Pound operator +(Mass other) => Pound(value + other.toPound().value);

  @override
  Pound operator -(Mass other) => Pound(value - other.toPound().value);

  @override
  Pound operator *(num factors) => Pound(value * factors.toDouble());

  @override
  Pound operator /(num divisor) => Pound(value / divisor);
}
