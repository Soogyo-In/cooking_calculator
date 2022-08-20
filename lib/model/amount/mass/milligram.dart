part of 'mass.dart';

@freezed
class Milligram with _$Milligram implements Mass {
  @override
  final symbol = milligramSymbol;

  const Milligram._();

  const factory Milligram(double value) = _Milligram;

  @override
  Gram toGram() => Gram(gramPerMilligram * value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerMilligram * value);

  @override
  Milligram toMilligram() => Milligram(value);

  @override
  Ounce toOunce() => Ounce(ouncePerMilligram * value);

  @override
  Pound toPound() => Pound(poundPerMilligram * value);

  @override
  Milligram roundedAt(int fractionDigits) =>
      Milligram(value.roundAt(fractionDigits));

  @override
  Milligram operator +(Mass other) =>
      Milligram(value + other.toMilligram().value);

  @override
  Milligram operator -(Mass other) =>
      Milligram(value - other.toMilligram().value);

  @override
  Milligram operator *(num factors) => Milligram(value * factors.toDouble());

  @override
  Milligram operator /(num divisor) => Milligram(value / divisor);
}
