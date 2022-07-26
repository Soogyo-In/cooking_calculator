part of 'mass.dart';

@freezed
class Ounce with _$Ounce implements Mass {
  static const abbreviation = 'oz';

  const Ounce._();

  const factory Ounce(double value) = _Ounce;

  @override
  Gram toGram() => Gram(gramPerOunce * value);

  @override
  Kilogram toKilogram() => Kilogram(kilogramPerOunce * value);

  @override
  Milligram toMilligram() => Milligram(milligramPerOunce * value);

  @override
  Ounce toOunce() => Ounce(value);

  @override
  Pound toPound() => Pound(poundPerOunce * value);

  @override
  Ounce operator +(Mass other) => Ounce(value + other.toOunce().value);

  @override
  Ounce operator -(Mass other) => Ounce(value - other.toOunce().value);

  @override
  Ounce operator *(num factors) => Ounce(value * factors.toDouble());

  @override
  Ounce operator /(num divisor) => Ounce(value / divisor);

  @override
  String toStringAsFixed(int fractionDigits) =>
      '${value.toStringAsFixed(fractionDigits)} $abbreviation';
}
