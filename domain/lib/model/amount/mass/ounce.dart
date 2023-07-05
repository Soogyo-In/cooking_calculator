part of 'mass.dart';

const ounceSymbol = 'oz';

final class Ounce extends Mass {
  Ounce(double value)
      : _inMilligrams = (milligramPerOunce * value).round(),
        super(
          symbol: ounceSymbol,
          value: value,
        );

  @override
  final int _inMilligrams;

  @override
  Gram toGram() => Gram(gramPerOunce * value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerOunce * value);

  @override
  Milligram toMilligram() => Milligram((milligramPerOunce * value).round());

  @override
  Ounce toOunce() => Ounce(value);

  @override
  Pound toPound() => Pound(poundPerOunce * value);

  @override
  Ounce roundedAt(int fractionDigits) => Ounce(value.roundAt(fractionDigits));

  @override
  Ounce operator +(Mass other) => Ounce(value + other.toOunce().value);

  @override
  Ounce operator -(Mass other) => Ounce(value - other.toOunce().value);

  @override
  Ounce operator *(num factor) => Ounce(value * factor);

  @override
  Ounce operator /(num divisor) => Ounce(value / divisor);

  @override
  Ounce copyWith({covariant double? value}) => Ounce(value ?? this.value);
}
