import 'package:data/data.dart';

import '../enum/amount_unit.dart';

extension AmountMapper on Amount {
  AmountUnit? get unit => switch (this) {
        Mass() => MassMapper(this as Mass).unit,
        Volume() => VolumeMapper(this as Volume).unit,
        Count() => CountMapper(this as Count).unit,
        Amount() => null,
      } as AmountUnit?;
}

extension MassMapper on Mass {
  MassUnit get unit => switch (this) {
        Milligram() => MassUnit.milligram,
        Gram() => MassUnit.gram,
        Kilogram() => MassUnit.kilogram,
        Ounce() => MassUnit.ounce,
        Pound() => MassUnit.pound,
      };
}

extension VolumeMapper on Volume {
  VolumeUnit get unit => switch (this) {
        CubicCentimeter() => VolumeUnit.cubicCentimeter,
        Milliliter() => VolumeUnit.milliliter,
        Liter() => VolumeUnit.liter,
        Teaspoon() => VolumeUnit.teaspoon,
        Tablespoon() => VolumeUnit.tablespoon,
        FluidOunce() => VolumeUnit.fluidOunce,
        Cup() => VolumeUnit.cup,
      };
}

extension CountMapper on Count {
  CountUnit get unit => CountUnit.piece;
}
