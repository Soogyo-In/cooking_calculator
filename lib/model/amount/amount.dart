import 'package:data/data.dart';

import '../enum/amount_unit.dart';

extension MassConverter on Mass {
  MassUnit get unit {
    if (this is Milligram) return MassUnit.milligram;
    if (this is Gram) return MassUnit.gram;
    if (this is Kilogram) return MassUnit.kilogram;
    if (this is Ounce) return MassUnit.ounce;
    if (this is Pound) return MassUnit.pound;
    throw StateError('Unsupported unit $this');
  }
}

extension VolumeConverter on Volume {
  VolumeUnit get unit {
    if (this is CubicCentimeter) return VolumeUnit.cubicCentimeter;
    if (this is Milliliter) return VolumeUnit.milliliter;
    if (this is Liter) return VolumeUnit.liter;
    if (this is Teaspoon) return VolumeUnit.teaspoon;
    if (this is Tablespoon) return VolumeUnit.tablespoon;
    if (this is FluidOunce) return VolumeUnit.fluidOunce;
    if (this is Cup) return VolumeUnit.cup;
    throw StateError('Unsupported unit $this');
  }
}
