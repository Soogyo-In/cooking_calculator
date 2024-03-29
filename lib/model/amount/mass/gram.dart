part of 'mass.dart';

@freezed
class Gram with _$Gram implements Mass {
  @override
  final symbol = gramSymbol;

  const Gram._();

  const factory Gram(double value) = _Gram;

  @override
  Gram toGram() => Gram(value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerGram * value);

  @override
  Milligram toMilligram() => Milligram(milligramPerGram * value);

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
  Gram operator *(num factors) => Gram(value * factors.toDouble());

  @override
  Gram operator /(num divisor) => Gram(value / divisor);
}
