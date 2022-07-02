part of 'amount.dart';

const gramPerKilogram = 1000.0;
const gramPerOunce = 28.349523125;
const gramPerPound = 453.59237;

const milligramPerGram = 1000.0;
const kilogramPerGram = 1.0 / gramPerKilogram;
const ouncePerGram = 1.0 / gramPerOunce;
const poundPerGram = 1.0 / gramPerPound;

const gramPerMilligram = 1.0 / milligramPerGram;
const kilogramPerMilligram = 1.0 / milligramPerKilogram;
const ouncePerMilligram = ouncePerGram * gramPerMilligram;
const poundPerMilligram = poundPerGram * gramPerMilligram;

const milligramPerKilogram = milligramPerGram * gramPerKilogram;
const ouncePerKilogram = ouncePerGram * gramPerKilogram;
const poundPerKilogram = poundPerGram * gramPerKilogram;

const milligramPerOunce = milligramPerGram * gramPerOunce;
const kilogramPerOunce = kilogramPerGram * gramPerOunce;
const poundPerOunce = poundPerGram * gramPerOunce;

const milligramPerPound = milligramPerGram * gramPerPound;
const kilogramPerPound = kilogramPerGram * gramPerPound;
const ouncePerPound = ouncePerGram * gramPerPound;

abstract class Mass implements Amount {
  factory Mass.milligram(double value) = Milligram;

  factory Mass.gram(double value) = Gram;

  factory Mass.kilogram(double value) = Kilogram;

  factory Mass.ounce(double value) = Ounce;

  factory Mass.pound(double value) = Pound;

  String get abbreviation;

  Milligram toMilligram();

  Gram toGram();

  Kilogram toKilogram();

  Ounce toOunce();

  Pound toPound();
}

@freezed
class Milligram with _$Milligram implements Mass {
  static const abbr = 'mg';

  const Milligram._();

  const factory Milligram.__(double value, String abbreviation) = _Milligram;

  factory Milligram(double value) => Milligram.__(value, abbr);

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

@freezed
class Gram with _$Gram implements Mass {
  static const abbr = 'g';

  const Gram._();

  const factory Gram.__(double value, String abbreviation) = _Gram;

  factory Gram(double value) => Gram.__(value, abbr);

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
  Gram operator +(Mass other) => Gram(value + other.toGram().value);

  @override
  Gram operator -(Mass other) => Gram(value - other.toGram().value);

  @override
  Gram operator *(num factors) => Gram(value * factors.toDouble());

  @override
  Gram operator /(num divisor) => Gram(value / divisor);
}

@freezed
class Kilogram with _$Kilogram implements Mass {
  static const abbr = 'kg';

  const Kilogram._();

  const factory Kilogram.__(double value, String abbreviation) = _Kilogram;

  factory Kilogram(double value) => Kilogram.__(value, abbr);

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
  Kilogram operator +(Mass other) => Kilogram(value + other.toKilogram().value);

  @override
  Kilogram operator -(Mass other) => Kilogram(value - other.toKilogram().value);

  @override
  Kilogram operator *(num factors) => Kilogram(value * factors.toDouble());

  @override
  Kilogram operator /(num divisor) => Kilogram(value / divisor);
}

@freezed
class Ounce with _$Ounce implements Mass {
  static const abbr = 'oz';

  const Ounce._();

  const factory Ounce.__(double value, String abbreviation) = _Ounce;

  factory Ounce(double value) => Ounce.__(value, abbr);

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
}

@freezed
class Pound with _$Pound implements Mass {
  static const abbr = 'lb';

  const Pound._();

  const factory Pound.__(double value, String abbreviation) = _Pound;

  factory Pound(double value) => Pound.__(value, abbr);

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
  Pound operator +(Mass other) => Pound(value + other.toPound().value);

  @override
  Pound operator -(Mass other) => Pound(value - other.toPound().value);

  @override
  Pound operator *(num factors) => Pound(value * factors.toDouble());

  @override
  Pound operator /(num divisor) => Pound(value / divisor);
}
