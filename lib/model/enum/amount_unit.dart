import 'package:data/data.dart';

abstract class AmountUnit<T extends Amount> {
  String get symbol;

  T toAmount(double value);
}

enum MassUnit implements AmountUnit<Mass> {
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
        return Milligram(value.toInt());
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

enum VolumeUnit implements AmountUnit<Volume> {
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
        return CubicCentimeter(value.toInt());
      case VolumeUnit.milliliter:
        return Milliliter(value.toInt());
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

enum CountUnit implements AmountUnit<Count> {
  piece(countSymbol);

  @override
  final String symbol;

  const CountUnit(this.symbol);

  @override
  Count toAmount(double value) => Count(value);
}
