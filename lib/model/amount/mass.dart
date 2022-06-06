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

  factory Mass.fromJson(Map<String, dynamic> json) {
    final abbreviation = json['abbreviation'];

    switch (abbreviation) {
      case Milligram.abbr:
        return Milligram.fromJson(json);
      case Gram.abbr:
        return Gram.fromJson(json);
      case Kilogram.abbr:
        return Kilogram.fromJson(json);
      case Ounce.abbr:
        return Ounce.fromJson(json);
      case Pound.abbr:
        return Pound.fromJson(json);
    }

    throw CheckedFromJsonException(
      json,
      'abbreviation',
      'Mass',
      'Unsupported mass unit: $abbreviation',
    );
  }

  Map<String, dynamic> toJson() {
    if (this is Milligram) return (this as Milligram).toJson();
    if (this is Gram) return (this as Gram).toJson();
    if (this is Kilogram) return (this as Kilogram).toJson();
    if (this is Ounce) return (this as Ounce).toJson();
    if (this is Pound) return (this as Pound).toJson();

    throw JsonUnsupportedObjectError(this);
  }

  String get abbreviation;

  Mass toMilligram();

  Mass toGram();

  Mass toKilogram();

  Mass toOunce();

  Mass toPound();
}

@freezed
class Milligram with _$Milligram implements Mass {
  static const abbr = 'mg';

  const Milligram._();

  const factory Milligram.__(double value, String abbreviation) = _Milligram;

  factory Milligram(double value) => Milligram.__(value, abbr);

  factory Milligram.fromJson(Map<String, dynamic> json) =>
      _$MilligramFromJson(json);

  @override
  Mass toGram() => Gram(gramPerMilligram * value);

  @override
  Mass toKilogram() => Kilogram(kilogramPerMilligram * value);

  @override
  Mass toMilligram() => Milligram(value);

  @override
  Mass toOunce() => Ounce(ouncePerMilligram * value);

  @override
  Mass toPound() => Pound(poundPerMilligram * value);
}

@freezed
class Gram with _$Gram implements Mass {
  static const abbr = 'g';

  const Gram._();

  const factory Gram.__(double value, String abbreviation) = _Gram;

  factory Gram(double value) => Gram.__(value, abbr);

  factory Gram.fromJson(Map<String, dynamic> json) => _$GramFromJson(json);

  @override
  Mass toGram() => Gram(value);

  @override
  Mass toKilogram() => Kilogram(kilogramPerGram * value);

  @override
  Mass toMilligram() => Milligram(milligramPerGram * value);

  @override
  Mass toOunce() => Ounce(ouncePerGram * value);

  @override
  Mass toPound() => Pound(poundPerGram * value);
}

@freezed
class Kilogram with _$Kilogram implements Mass {
  static const abbr = 'kg';

  const Kilogram._();

  const factory Kilogram.__(double value, String abbreviation) = _Kilogram;

  factory Kilogram(double value) => Kilogram.__(value, abbr);

  factory Kilogram.fromJson(Map<String, dynamic> json) =>
      _$KilogramFromJson(json);

  @override
  Mass toGram() => Gram(gramPerKilogram * value);

  @override
  Mass toKilogram() => Kilogram(value);

  @override
  Mass toMilligram() => Milligram(milligramPerKilogram * value);

  @override
  Mass toOunce() => Ounce(ouncePerKilogram * value);

  @override
  Mass toPound() => Pound(poundPerKilogram * value);
}

@freezed
class Ounce with _$Ounce implements Mass {
  static const abbr = 'oz';

  const Ounce._();

  const factory Ounce.__(double value, String abbreviation) = _Ounce;

  factory Ounce(double value) => Ounce.__(value, abbr);

  factory Ounce.fromJson(Map<String, dynamic> json) => _$OunceFromJson(json);

  @override
  Mass toGram() => Gram(gramPerOunce * value);

  @override
  Mass toKilogram() => Kilogram(kilogramPerOunce * value);

  @override
  Mass toMilligram() => Milligram(milligramPerOunce * value);

  @override
  Mass toOunce() => Ounce(value);

  @override
  Mass toPound() => Pound(poundPerOunce * value);
}

@freezed
class Pound with _$Pound implements Mass {
  static const abbr = 'lb';

  const Pound._();

  const factory Pound.__(double value, String abbreviation) = _Pound;

  factory Pound(double value) => Pound.__(value, abbr);

  factory Pound.fromJson(Map<String, dynamic> json) => _$PoundFromJson(json);

  @override
  Mass toGram() => Gram(gramPerPound * value);

  @override
  Mass toKilogram() => Kilogram(kilogramPerPound * value);

  @override
  Mass toMilligram() => Milligram(milligramPerPound * value);

  @override
  Mass toOunce() => Ounce(ouncePerPound * value);

  @override
  Mass toPound() => Pound(value);
}
