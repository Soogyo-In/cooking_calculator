import 'package:data/data.dart';

abstract class AmountUnit<T extends Amount> {
  String get symbol;

  T toAmount(double value);
}

enum MassUnit implements AmountUnit {
  milligram(milligramSymbol),
  gram(gramSymbol),
  kilogram(kilogramSymbol),
  ounce(ounceSymbol),
  pound(poundSymbol);

  @override
  final String symbol;

  const MassUnit(this.symbol);

  @override
  Mass toAmount(double value) {
    switch (this) {
      case MassUnit.milligram:
        return Milligram(value);
      case MassUnit.gram:
        return Gram(value);
      case MassUnit.kilogram:
        return Kilogram(value);
      case MassUnit.ounce:
        return Ounce(value);
      case MassUnit.pound:
        return Pound(value);
    }
  }
}

enum VolumeUnit implements AmountUnit {
  cubicCentimeter(cubicCentimeterSymbol),
  milliliter(milliliterSymbol),
  liter(literSymbol),
  teaspoon(teaspoonSymbol),
  tablespoon(tablespoonSymbol),
  fluidOunce(fluidOunceSymbol),
  cup(cupSymbol);

  @override
  final String symbol;

  const VolumeUnit(this.symbol);

  @override
  Volume toAmount(double value) {
    switch (this) {
      case VolumeUnit.cubicCentimeter:
        return CubicCentimeter(value);
      case VolumeUnit.milliliter:
        return Milliliter(value);
      case VolumeUnit.liter:
        return Liter(value);
      case VolumeUnit.teaspoon:
        return Teaspoon(value);
      case VolumeUnit.tablespoon:
        return Tablespoon(value);
      case VolumeUnit.fluidOunce:
        return FluidOunce(value);
      case VolumeUnit.cup:
        return Cup(value);
    }
  }
}
