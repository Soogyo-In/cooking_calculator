import 'package:cooking_calulator/model/enum/enum.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AmountField<U extends AmountUnit, A extends Amount>
    extends ConsumerWidget {
  final A amount;
  final List<U>? units;
  final U? unit;
  final ValueChanged<String>? onValueChanged;
  final ValueChanged<U?>? onUnitChanged;
  final _textEditingController = TextEditingController();

  AmountField({
    required this.amount,
    this.units,
    this.unit,
    this.onValueChanged,
    this.onUnitChanged,
    super.key,
  });

  static AmountField<MassUnit, Mass> mass({
    required Mass mass,
    MassUnit? unit,
    ValueChanged<String>? onValueChanged,
    ValueChanged<MassUnit?>? onUnitChanged,
    Key? key,
  }) =>
      _MassField(
        amount: mass,
        unit: unit,
        onValueChanged: onValueChanged,
        onUnitChanged: onUnitChanged,
        key: key,
      );

  static AmountField<VolumeUnit, Volume> volume({
    required Volume volume,
    VolumeUnit? unit,
    ValueChanged<String>? onValueChanged,
    ValueChanged<VolumeUnit?>? onUnitChanged,
    Key? key,
  }) =>
      _VolumeField(
        amount: volume,
        unit: unit,
        onValueChanged: onValueChanged,
        onUnitChanged: onUnitChanged,
        key: key,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueString = buildNotatedValue(ref)?.toString() ?? '';
    _textEditingController.value = _textEditingController.value.copyWith(
      text: valueString,
      selection: _textEditingController.selection.isValid
          ? null
          : TextSelection.collapsed(offset: valueString.length - 1),
    );

    return Row(
      children: [
        SizedBox(
          width: 60.0,
          child: TextField(
            textAlign: TextAlign.end,
            controller: _textEditingController,
            onChanged: onValueChanged,
          ),
        ),
        SizedBox(
          width: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<U>(
                value: unit,
                items: units
                    ?.map((unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(unit.symbol),
                        ))
                    .toList(),
                onChanged: onUnitChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }

  double? buildNotatedValue(WidgetRef ref);
}

class _MassField extends AmountField<MassUnit, Mass> {
  _MassField({
    required super.amount,
    super.unit,
    super.onValueChanged,
    super.onUnitChanged,
    super.key,
  }) : super(units: MassUnit.values);

  @override
  double? buildNotatedValue(WidgetRef ref) {
    switch (unit) {
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
      default:
        return null;
    }
  }
}

class _VolumeField extends AmountField<VolumeUnit, Volume> {
  _VolumeField({
    required super.amount,
    super.unit,
    super.onValueChanged,
    super.onUnitChanged,
    super.key,
  }) : super(units: VolumeUnit.values);

  @override
  double? buildNotatedValue(WidgetRef ref) {
    switch (unit) {
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
      default:
        return null;
    }
  }
}
