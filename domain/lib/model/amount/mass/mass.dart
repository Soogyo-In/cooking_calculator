import 'package:domain/model/amount/amount.dart';
import 'package:domain/model/extension/extension.dart';

part 'gram.dart';
part 'kilogram.dart';
part 'milligram.dart';
part 'ounce.dart';
part 'pound.dart';

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

sealed class Mass extends Amount {
  Mass({
    required super.value,
    required super.symbol,
  });

  factory Mass.milligram(int value) = Milligram;

  factory Mass.gram(double value) = Gram;

  factory Mass.kilogram(double value) = Kilogram;

  factory Mass.ounce(double value) = Ounce;

  factory Mass.pound(double value) = Pound;

  @override
  List<Object?> get props => super.props..add(_inMilligrams);

  int get _inMilligrams;

  Milligram toMilligram();

  Gram toGram();

  Kilogram toKilogram();

  Ounce toOunce();

  Pound toPound();

  @override
  Mass operator +(Mass other);

  @override
  Mass operator -(Mass other);

  @override
  Mass operator *(num factor);

  @override
  Mass operator /(num divisor);

  @override
  bool operator <(covariant Mass other) => compareTo(other) < 0;

  @override
  bool operator >(covariant Mass other) => compareTo(other) > 0;

  @override
  bool operator <=(covariant Mass other) => compareTo(other) <= 0;

  @override
  bool operator >=(covariant Mass other) => compareTo(other) >= 0;

  @override
  int compareTo(covariant Mass other) =>
      _inMilligrams.compareTo(other._inMilligrams);
}
