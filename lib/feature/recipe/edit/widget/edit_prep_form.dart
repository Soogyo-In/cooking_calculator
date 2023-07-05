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
          ref.listen(
            editPrepFormViewModelProvider,
            _onStateChange,
          );
          final viewModel = ref.watch(editPrepFormViewModelProvider.notifier);
          final state = ref.watch(editPrepFormViewModelProvider);

          return Column(
            children: [
              TextField(
                decoration: const InputDecoration(hintText: '재료명'),
                onChanged: viewModel.updateIngredientSearchSuggestions,
                onSubmitted: viewModel.submitIngredientName,
              ),
              Expanded(
                child: _IngredientField(
                  onSelected: viewModel.selectIngredient,
                ),
              ),
              _AmountUnitField(onChanged: viewModel.changeAmountUnit),
              if (state.isValid)
                TextButton(
                  onPressed: viewModel.validateForm,
                  child: const Text('추가하기'),
                ),
            ],
          );
        },
      ),
    );
  }

  void _onStateChange(EditPrepFromState? previous, EditPrepFromState next) {
    if (previous?.isValidAmountUnit == false && next.isValidAmountUnit) {
      final amount = next.amountUnit?.toAmount(next.amountValue);
      final ingredient = next.ingredient;
      if (amount == null || ingredient == null) {
        return;
      }

      onSubmitted?.call(Prep(amount: amount, ingredient: ingredient));
    }
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
      children: suggestions
          .map((ingredient) => ListTile(
                onTap: () => onSelected?.call(ingredient),
                title: Text(ingredient.name),
              ))
          .toList(),
    );
  }
}

class _AmountUnitField extends ConsumerWidget {
  const _AmountUnitField({this.onChanged});

  final ValueChanged<AmountUnit?>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredient = ref.watch(
      editPrepFormViewModelProvider.select((state) => state.ingredient),
    );

    return Visibility(
      visible: ingredient != null,
      child: Row(
        children: [
          Expanded(
            child: IntegerInput(
              decoration: const InputDecoration(
                hintText: '용량',
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          _AmountUnitSelector(onChanged: onChanged),
        ],
      ),
    );
  }
}

class _AmountUnitSelector extends ConsumerWidget {
  const _AmountUnitSelector({this.onChanged});

  final ValueChanged<AmountUnit?>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountUnit = ref.watch(
      editPrepFormViewModelProvider.select((state) => state.amountUnit),
    );

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
