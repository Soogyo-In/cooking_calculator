part of 'enum.dart';

enum MatterUnit {
  milligram,
  gram,
  kilogram,
  ounce,
  pound,
  cubicCentimeter,
  milliliter,
  liter,
  teaspoon,
  tablespoon,
  fluidOunce,
  cup,
  count;

  bool get isMilligram => this == milligram;
  bool get isGram => this == gram;
  bool get isKilogram => this == kilogram;
  bool get isOunce => this == ounce;
  bool get isPound => this == pound;
  bool get isCubicCentimeter => this == cubicCentimeter;
  bool get isMilliliter => this == milliliter;
  bool get isLiter => this == liter;
  bool get isTeaspoon => this == teaspoon;
  bool get isTablespoon => this == tablespoon;
  bool get isFluidOunce => this == fluidOunce;
  bool get isCup => this == cup;
  bool get isCount => this == count;
}
