part of 'mapper.dart';

extension AmountMapper on domain.Amount {
  MatterUnit toMatterUnit() {
    if (this is domain.Milligram) return MatterUnit.milligram;
    if (this is domain.Gram) return MatterUnit.gram;
    if (this is domain.Kilogram) return MatterUnit.kilogram;
    if (this is domain.Ounce) return MatterUnit.ounce;
    if (this is domain.Pound) return MatterUnit.pound;
    if (this is domain.CubicCentimeter) return MatterUnit.cubicCentimeter;
    if (this is domain.Milliliter) return MatterUnit.milliliter;
    if (this is domain.Liter) return MatterUnit.liter;
    if (this is domain.Teaspoon) return MatterUnit.teaspoon;
    if (this is domain.Tablespoon) return MatterUnit.tablespoon;
    if (this is domain.FluidOunce) return MatterUnit.fluidOunce;
    if (this is domain.Cup) return MatterUnit.cup;
    if (this is domain.Count) return MatterUnit.count;
    throw StateError('Unsupported type $runtimeType');
  }
}
