part of 'mass.dart';

const kilogramSymbol = 'kg';

final class Kilogram extends Mass {
  Kilogram(double value)
      : _inMilligrams = (milligramPerKilogram * value).round(),
        super(
          symbol: kilogramSymbol,
          value: value,
        );

  @override
  final int _inMilligrams;

  @override
  Gram toGram() => Gram(gramPerKilogram * value);

  @override
  Kilogram toKilogram() => Kilogram(value);

  @override
  Milligram toMilligram() => Milligram((milligramPerKilogram * value).round());

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
  Kilogram operator *(num factor) => Kilogram(value * factor);

  @override
  Kilogram operator /(num divisor) => Kilogram(value / divisor);
}
