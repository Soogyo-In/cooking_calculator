part of 'model_mapper.dart';

extension AmountMapper on Amount {
  MatterUnit toMatterUnit() {
    if (this is Milligram) return MatterUnit.milligram;
    if (this is Gram) return MatterUnit.gram;
    if (this is Kilogram) return MatterUnit.kilogram;
    if (this is Ounce) return MatterUnit.ounce;
    if (this is Pound) return MatterUnit.pound;
    if (this is CubicCentimeter) return MatterUnit.cubicCentimeter;
    if (this is Milliliter) return MatterUnit.milliliter;
    if (this is Liter) return MatterUnit.liter;
    if (this is Teaspoon) return MatterUnit.teaspoon;
    if (this is Tablespoon) return MatterUnit.tablespoon;
    if (this is FluidOunce) return MatterUnit.fluidOunce;
    if (this is Cup) return MatterUnit.cup;
    if (this is Count) return MatterUnit.count;
    throw StateError('Unsupported type $runtimeType');
  }
}
