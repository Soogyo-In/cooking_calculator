part of 'amount.dart';

enum MassUnit {
  milligram,
  gram,
  kilogram,
  ounce,
  pound,
}

extension MassUnitExpression on MassUnit {
  String get abbreviation {
    switch (this) {
      case MassUnit.milligram:
        return 'mg';
      case MassUnit.gram:
        return 'g';
      case MassUnit.kilogram:
        return 'kg';
      case MassUnit.ounce:
        return 'oz';
      case MassUnit.pound:
        return 'lb';
    }
  }
}

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

@freezed
class Mass with _$Mass implements Amount {
  const Mass._();

  factory Mass.__(double value, MassUnit unit) = _Mass;

  factory Mass(double value, MassUnit unit) {
    if (value.isNegative) throw NegativeValueException();
    return Mass.__(value, unit);
  }

  factory Mass.milligram(double value) => Mass(value, MassUnit.milligram);

  factory Mass.gram(double value) => Mass(value, MassUnit.gram);

  factory Mass.kilogram(double value) => Mass(value, MassUnit.kilogram);

  factory Mass.ounce(double value) => Mass(value, MassUnit.ounce);

  factory Mass.pound(double value) => Mass(value, MassUnit.pound);

  factory Mass.fromJson(Map<String, dynamic> json) => _$MassFromJson(json);

  Mass toMilligram() {
    switch (unit) {
      case MassUnit.milligram:
        return this;
      case MassUnit.gram:
        return Mass.milligram(value * milligramPerGram);
      case MassUnit.kilogram:
        return Mass.milligram(value * milligramPerKilogram);
      case MassUnit.ounce:
        return Mass.milligram(value * milligramPerOunce);
      case MassUnit.pound:
        return Mass.milligram(value * milligramPerPound);
    }
  }

  Mass toGram() {
    switch (unit) {
      case MassUnit.milligram:
        return Mass.gram(value * gramPerMilligram);
      case MassUnit.gram:
        return this;
      case MassUnit.kilogram:
        return Mass.gram(value * gramPerKilogram);
      case MassUnit.ounce:
        return Mass.gram(value * gramPerOunce);
      case MassUnit.pound:
        return Mass.gram(value * gramPerPound);
    }
  }

  Mass toKilogram() {
    switch (unit) {
      case MassUnit.milligram:
        return Mass.kilogram(value * kilogramPerMilligram);
      case MassUnit.gram:
        return Mass.kilogram(value * kilogramPerGram);
      case MassUnit.kilogram:
        return this;
      case MassUnit.ounce:
        return Mass.kilogram(value * kilogramPerOunce);
      case MassUnit.pound:
        return Mass.kilogram(value * kilogramPerPound);
    }
  }

  Mass toOunce() {
    switch (unit) {
      case MassUnit.milligram:
        return Mass.ounce(value * ouncePerMilligram);
      case MassUnit.gram:
        return Mass.ounce(value * ouncePerGram);
      case MassUnit.kilogram:
        return Mass.ounce(value * ouncePerKilogram);
      case MassUnit.ounce:
        return this;
      case MassUnit.pound:
        return Mass.ounce(value * ouncePerPound);
    }
  }

  Mass toPound() {
    switch (unit) {
      case MassUnit.milligram:
        return Mass.pound(value * poundPerMilligram);
      case MassUnit.gram:
        return Mass.pound(value * poundPerGram);
      case MassUnit.kilogram:
        return Mass.pound(value * poundPerKilogram);
      case MassUnit.ounce:
        return Mass.pound(value * poundPerOunce);
      case MassUnit.pound:
        return this;
    }
  }
}
