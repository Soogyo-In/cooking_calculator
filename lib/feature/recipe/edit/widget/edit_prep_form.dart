import 'package:cooking_calulator/feature/view_model/edit_prep_form/edit_prep_form_view_model.dart';
import 'package:cooking_calulator/model/enum/amount_unit.dart';
import 'package:cooking_calulator/widget/widget.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPrepForm extends ConsumerWidget {
  const EditPrepForm({
    super.key,
    this.prep,
    this.onSubmitted,
  });

  final Prep? prep;

  final ValueSetter<Prep>? onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        editPrepFormViewModelProvider.overrideWith(
          () => EditPrepFormViewModel(prep: prep),
        ),
      ],
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final viewModel = ref.watch(editPrepFormViewModelProvider.notifier);
          final state = ref.watch(editPrepFormViewModelProvider);

          return Column(
            children: [
              TextFormField(
                initialValue: state.ingredient?.name,
                decoration: const InputDecoration(hintText: '재료명'),
                onChanged: viewModel.updateIngredientSearchSuggestions,
                onFieldSubmitted: viewModel.submitIngredientName,
              ),
              _IngredientField(
                onSelected: viewModel.selectIngredient,
              ),
              if (state.ingredient != null)
                _AmountUnitField(
                  initialValue: state.amountValue.toInt().toString(),
                  amountUnit: state.amountUnit,
                  onValueChanged: viewModel.changeAmountValue,
                  onUnitChanged: viewModel.changeAmountUnit,
                ),
              if (state.isValid)
                TextButton(
                  onPressed: () => _onSubmitButtonPressed(state),
                  child: const Text('추가하기'),
                ),
            ],
          );
        },
      ),
    );
  }

  void _onSubmitButtonPressed(EditPrepFromState state) {
    final amount = state.amountUnit!.toAmount(state.amountValue);
    final ingredient = state.ingredient!;
    onSubmitted?.call(Prep(amount: amount, ingredient: ingredient));
  }
}

class _IngredientField extends ConsumerWidget {
  const _IngredientField({this.onSelected});

  final ValueChanged<Ingredient>? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestions = ref.watch(
      editPrepFormViewModelProvider.select(
        (state) => state.ingredientSearchSuggestions,
      ),
    );

    return ListView(
      shrinkWrap: true,
      children: suggestions
          .map((ingredient) => ListTile(
                onTap: () => onSelected?.call(ingredient),
                title: Text(ingredient.name),
              ))
          .toList(),
    );
  }
}

class _AmountUnitField extends StatelessWidget {
  const _AmountUnitField({
    this.initialValue,
    this.amountUnit,
    this.onValueChanged,
    this.onUnitChanged,
  });

  final String? initialValue;
  final AmountUnit? amountUnit;
  final ValueChanged<String>? onValueChanged;
  final ValueChanged<AmountUnit?>? onUnitChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IntegerInput(
            initialValue: initialValue,
            onChanged: onValueChanged,
            decoration: const InputDecoration(
              hintText: '용량',
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        _AmountUnitSelector(
          amountUnit: amountUnit,
          onChanged: onUnitChanged,
        ),
      ],
    );
  }
}

class _AmountUnitSelector extends StatelessWidget {
  const _AmountUnitSelector({
    this.amountUnit,
    this.onChanged,
  });

  final AmountUnit? amountUnit;
  final ValueChanged<AmountUnit?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AmountUnit>(
      onChanged: onChanged,
      value: amountUnit,
      items: [
        ...MassUnit.values.map(
          (unit) => DropdownMenuItem(
            value: unit,
            child: Text(unit.symbol),
          ),
        ),
        ...VolumeUnit.values.map(
          (unit) => DropdownMenuItem(
            value: unit,
            child: Text(unit.symbol),
          ),
        ),
        DropdownMenuItem(
          value: CountUnit.piece,
          child: Text(CountUnit.piece.symbol),
        ),
      ],
    );
  }
}
