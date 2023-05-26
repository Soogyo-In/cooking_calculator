part of 'mass.dart';

const milligramSymbol = 'mg';

final class Milligram extends Mass {
  Milligram(int value)
      : super(
          symbol: milligramSymbol,
          value: value.toDouble(),
        );

  @override
  int get _inMilligrams => value.toInt();

  @override
  Gram toGram() => Gram(gramPerMilligram * value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerMilligram * value);

  @override
  Milligram toMilligram() => Milligram(value.toInt());

  @override
  Ounce toOunce() => Ounce(ouncePerMilligram * value);

  @override
  Pound toPound() => Pound(poundPerMilligram * value);

  @override
  Milligram roundedAt(int fractionDigits) => Milligram(value.toInt());

  @override
  Milligram operator +(Mass other) =>
      Milligram((value + other.toMilligram().value).round());

  @override
  Milligram operator -(Mass other) =>
      Milligram((value - other.toMilligram().value).round());

  @override
  Milligram operator *(num factor) => Milligram((value * factor).round());

  @override
  Milligram operator /(num divisor) => Milligram((value / divisor).round());
}
