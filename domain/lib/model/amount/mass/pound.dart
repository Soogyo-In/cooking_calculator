part of 'mass.dart';

const poundSymbol = 'lb';

final class Pound extends Mass {
  Pound(double value)
      : _inMilligrams = (milligramPerPound * value).round(),
        super(
          symbol: poundSymbol,
          value: value,
        );

  @override
  final int _inMilligrams;

  @override
  Gram toGram() => Gram(gramPerPound * value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerPound * value);

  @override
  Milligram toMilligram() => Milligram((milligramPerPound * value).round());

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
  Pound operator *(num factor) => Pound(value * factor);

  @override
  Pound operator /(num divisor) => Pound(value / divisor);
}
