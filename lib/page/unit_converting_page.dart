import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AmountUnit<T extends Amount> {
  String get abbreviation;

  T toAmount(double value);
}

enum MassUnit implements AmountUnit {
  milligram(milligramSymbol),
  gram(gramSymbol),
  kilogram(kilogramSymbol),
  ounce(ounceSymbol),
  pound(poundSymbol);

  @override
  final String abbreviation;

  const MassUnit(this.abbreviation);

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
  final String abbreviation;

  const VolumeUnit(this.abbreviation);

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

final _fromMassUnitProvider = StateProvider((ref) => MassUnit.milligram);
final _toMassUnitProvider = StateProvider((ref) => MassUnit.milligram);
final _massValueProvider = StateProvider<double?>((ref) => null);
final _fromVolumeUnitProvider =
    StateProvider((ref) => VolumeUnit.cubicCentimeter);
final _toVolumeUnitProvider =
    StateProvider((ref) => VolumeUnit.cubicCentimeter);
final _volumeValueProvider = StateProvider<double?>((ref) => null);

class UnitConvertingPage extends ConsumerWidget {
  const UnitConvertingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            UnitConverter.mass(
              fromUnitProvider: _fromMassUnitProvider,
              toUnitProvider: _toMassUnitProvider,
              valueProvider: _massValueProvider,
            ),
            const SizedBox(height: 8.0),
            UnitConverter.volume(
              fromUnitProvider: _fromVolumeUnitProvider,
              toUnitProvider: _toVolumeUnitProvider,
              valueProvider: _volumeValueProvider,
            ),
          ],
        ),
      ),
    );
  }
}

abstract class UnitConverter<T extends AmountUnit> extends ConsumerWidget {
  final List<T> units;
  final StateProvider<T> fromUnitProvider;
  final StateProvider<T> toUnitProvider;
  final StateProvider<double?> valueProvider;

  const UnitConverter({
    required this.units,
    required this.fromUnitProvider,
    required this.toUnitProvider,
    required this.valueProvider,
    super.key,
  });

  static UnitConverter<MassUnit> mass({
    required StateProvider<MassUnit> fromUnitProvider,
    required StateProvider<MassUnit> toUnitProvider,
    required StateProvider<double?> valueProvider,
    Key? key,
  }) =>
      _MassUnitConverter(
        fromUnitProvider: fromUnitProvider,
        toUnitProvider: toUnitProvider,
        valueProvider: valueProvider,
        key: key,
      );

  static UnitConverter<VolumeUnit> volume({
    required StateProvider<VolumeUnit> fromUnitProvider,
    required StateProvider<VolumeUnit> toUnitProvider,
    required StateProvider<double?> valueProvider,
    Key? key,
  }) =>
      _VolumeUnitConverter(
        fromUnitProvider: fromUnitProvider,
        toUnitProvider: toUnitProvider,
        valueProvider: valueProvider,
        key: key,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            onChanged: (text) =>
                ref.watch(valueProvider.state).state = double.tryParse(text),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('from'),
        ),
        DropdownButton<T>(
          value: ref.watch(fromUnitProvider),
          items: units
              .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit.abbreviation),
                  ))
              .toList(),
          onChanged: (unit) {
            if (unit == null) return;
            ref.watch(fromUnitProvider.state).state = unit;
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('to'),
        ),
        DropdownButton<T>(
          value: ref.watch(toUnitProvider),
          items: units
              .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit.abbreviation),
                  ))
              .toList(),
          onChanged: (unit) {
            if (unit == null) return;
            ref.watch(toUnitProvider.state).state = unit;
          },
        ),
        Expanded(
          child: Text(
            buildNotatedValueString(ref),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String buildNotatedValueString(WidgetRef ref);
}

class _MassUnitConverter extends UnitConverter<MassUnit> {
  const _MassUnitConverter({
    required super.fromUnitProvider,
    required super.toUnitProvider,
    required super.valueProvider,
    super.key,
  }) : super(units: MassUnit.values);

  @override
  String buildNotatedValueString(WidgetRef ref) {
    final value = ref.watch(valueProvider);
    if (value == null) return 'converted';

    final fromValue = ref.watch(fromUnitProvider).toAmount(value);

    switch (ref.watch(toUnitProvider)) {
      case MassUnit.milligram:
        return fromValue.toMilligram().roundedAt(3).toStringWithSymbol();
      case MassUnit.gram:
        return fromValue.toGram().roundedAt(3).toStringWithSymbol();
      case MassUnit.kilogram:
        return fromValue.toKilogram().roundedAt(3).toStringWithSymbol();
      case MassUnit.ounce:
        return fromValue.toOunce().roundedAt(3).toStringWithSymbol();
      case MassUnit.pound:
        return fromValue.toPound().roundedAt(3).toStringWithSymbol();
    }
  }
}

class _VolumeUnitConverter extends UnitConverter<VolumeUnit> {
  const _VolumeUnitConverter({
    required super.fromUnitProvider,
    required super.toUnitProvider,
    required super.valueProvider,
    super.key,
  }) : super(units: VolumeUnit.values);

  @override
  String buildNotatedValueString(WidgetRef ref) {
    final value = ref.watch(valueProvider);
    if (value == null) return 'converted';

    final fromValue = ref.watch(fromUnitProvider).toAmount(value);

    switch (ref.watch(toUnitProvider)) {
      case VolumeUnit.cubicCentimeter:
        return fromValue.toCubicCentimeter().roundedAt(3).toStringWithSymbol();
      case VolumeUnit.milliliter:
        return fromValue.toMilliliter().roundedAt(3).toStringWithSymbol();
      case VolumeUnit.liter:
        return fromValue.toLiter().roundedAt(3).toStringWithSymbol();
      case VolumeUnit.teaspoon:
        return fromValue.toTeaspoon().roundedAt(3).toStringWithSymbol();
      case VolumeUnit.tablespoon:
        return fromValue.toTablespoon().roundedAt(3).toStringWithSymbol();
      case VolumeUnit.fluidOunce:
        return fromValue.toFluidOunce().roundedAt(3).toStringWithSymbol();
      case VolumeUnit.cup:
        return fromValue.toCup().roundedAt(3).toStringWithSymbol();
    }
  }
}
