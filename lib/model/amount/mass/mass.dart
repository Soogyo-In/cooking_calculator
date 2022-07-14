import 'package:freezed_annotation/freezed_annotation.dart';

import '../amount.dart';

part 'gram.dart';
part 'kilogram.dart';
part 'milligram.dart';
part 'ounce.dart';
part 'pound.dart';
part 'mass.freezed.dart';

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

  Milligram toMilligram();

  Gram toGram();

  Kilogram toKilogram();

  Ounce toOunce();

  Pound toPound();
}
