part of 'mass.dart';

const gramSymbol = 'g';

final class Gram extends Mass {
  Gram(double value)
      : _inMilligrams = (milligramPerGram * value).round(),
        super(
          symbol: gramSymbol,
          value: value,
        );

  @override
  final int _inMilligrams;

  @override
  Gram toGram() => Gram(value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerGram * value);

  @override
  Milligram toMilligram() => Milligram((milligramPerGram * value).round());

  @override
  Ounce toOunce() => Ounce(ouncePerGram * value);

  @override
  Pound toPound() => Pound(poundPerGram * value);

  @override
  Gram roundedAt(int fractionDigits) => Gram(value.roundAt(fractionDigits));

  @override
  Gram operator +(Mass other) => Gram(value + other.toGram().value);

  @override
  Gram operator -(Mass other) => Gram(value - other.toGram().value);

  @override
  Gram operator *(num factor) => Gram(value * factor);

  @override
  Gram operator /(num divisor) => Gram(value / divisor);
}
