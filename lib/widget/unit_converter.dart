import 'package:cooking_calulator/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AmountUnit<T extends Amount> {
  String get abbreviation;

  T toAmount(double value);
}

enum MassUnit implements AmountUnit<Mass> {
  milligram(milligramSymbol),
  gram(gramSymbol),
  kilogram(kilogramSymbol),
  ounce(ounceSymbol),
  pound(poundSymbol);

  const MassUnit(this.abbreviation);

  @override
  final String abbreviation;

  static MassUnit fromAmount(Mass mass) {
    if (mass is Milligram) return milligram;
    if (mass is Gram) return gram;
    if (mass is Kilogram) return kilogram;
    if (mass is Ounce) return ounce;
    if (mass is Pound) return pound;
    throw ArgumentError.value(mass, 'mass', 'unsupported unit');
  }

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

enum VolumeUnit implements AmountUnit<Volume> {
  cubicCentimeter(cubicCentimeterSymbol),
  milliliter(milliliterSymbol),
  liter(literSymbol),
  teaspoon(teaspoonSymbol),
  tablespoon(tablespoonSymbol),
  fluidOunce(fluidOunceSymbol),
  cup(cupSymbol);

  const VolumeUnit(this.abbreviation);

  @override
  final String abbreviation;

  static VolumeUnit fromAmount(Volume volume) {
    if (volume is CubicCentimeter) return cubicCentimeter;
    if (volume is Milliliter) return milliliter;
    if (volume is Liter) return liter;
    if (volume is Teaspoon) return teaspoon;
    if (volume is Tablespoon) return tablespoon;
    if (volume is FluidOunce) return fluidOunce;
    if (volume is Cup) return cup;
    throw ArgumentError.value(volume, 'volume', 'unsupported unit');
  }

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

abstract class UnitConverter<U extends AmountUnit, A extends Amount>
    extends ConsumerWidget {
  final List<U> units;
  final StateProvider<U> unitProvider;
  final A amount;

  const UnitConverter({
    required this.units,
    required this.unitProvider,
    required this.amount,
    super.key,
  });

  static UnitConverter<MassUnit, Mass> mass({
    required Mass mass,
    Key? key,
  }) =>
      _MassUnitConverter(
        unitProvider: StateProvider((ref) => MassUnit.fromAmount(mass)),
        amount: mass,
        key: key,
      );

  static UnitConverter<VolumeUnit, Volume> volume({
    required Volume volume,
    Key? key,
  }) =>
      _VolumeUnitConverter(
        unitProvider: StateProvider((ref) => VolumeUnit.fromAmount(volume)),
        amount: volume,
        key: key,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(buildNotatedValue(ref).toString()),
        SizedBox(
          width: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<U>(
                value: ref.watch(unitProvider),
                items: units
                    .map((unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(unit.abbreviation),
                        ))
                    .toList(),
                onChanged: (unit) {
                  if (unit == null) return;
                  ref.watch(unitProvider.state).state = unit;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  double buildNotatedValue(WidgetRef ref);
}

class _MassUnitConverter extends UnitConverter<MassUnit, Mass> {
  const _MassUnitConverter({
    required super.unitProvider,
    required super.amount,
    super.key,
  }) : super(units: MassUnit.values);

  @override
  double buildNotatedValue(WidgetRef ref) {
    switch (ref.watch(unitProvider)) {
      case MassUnit.milligram:
        return amount.toMilligram().roundedAt(3).value;
      case MassUnit.gram:
        return amount.toGram().roundedAt(3).value;
      case MassUnit.kilogram:
        return amount.toKilogram().roundedAt(3).value;
      case MassUnit.ounce:
        return amount.toOunce().roundedAt(3).value;
      case MassUnit.pound:
        return amount.toPound().roundedAt(3).value;
    }
  }
}

class _VolumeUnitConverter extends UnitConverter<VolumeUnit, Volume> {
  const _VolumeUnitConverter({
    required super.unitProvider,
    required super.amount,
    super.key,
  }) : super(units: VolumeUnit.values);

  @override
  double buildNotatedValue(WidgetRef ref) {
    switch (ref.watch(unitProvider)) {
      case VolumeUnit.cubicCentimeter:
        return amount.toCubicCentimeter().roundedAt(3).value;
      case VolumeUnit.milliliter:
        return amount.toMilliliter().roundedAt(3).value;
      case VolumeUnit.liter:
        return amount.toLiter().roundedAt(3).value;
      case VolumeUnit.teaspoon:
        return amount.toTeaspoon().roundedAt(3).value;
      case VolumeUnit.tablespoon:
        return amount.toTablespoon().roundedAt(3).value;
      case VolumeUnit.fluidOunce:
        return amount.toFluidOunce().roundedAt(3).value;
      case VolumeUnit.cup:
        return amount.toCup().roundedAt(3).value;
    }
  }
}
