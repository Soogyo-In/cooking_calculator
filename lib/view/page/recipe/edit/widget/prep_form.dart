import 'package:cooking_calulator/feature/feature.dart';
import 'package:cooking_calulator/model/enum/amount_unit.dart';
import 'package:cooking_calulator/view/widget/widget.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrepForm extends ConsumerStatefulWidget {
  const PrepForm({
    super.key,
    this.prep,
    this.onSubmitted,
  });

  final Prep? prep;

  final ValueSetter<Prep>? onSubmitted;

  @override
  ConsumerState<PrepForm> createState() => _PrepFormState();
}

class _PrepFormState extends ConsumerState<PrepForm> {
  late final AutoDisposeFamilyNotifierProvider<EditPrepFormIntent,
      EditPrepFormState, Prep?> _intentProvider;

  final _ingredientSearchKeywordEditingController = TextEditingController();

  @override
  void initState() {
    _intentProvider = editPrepFormIntentProvider(widget.prep);
    _ingredientSearchKeywordEditingController.text =
        widget.prep?.ingredient.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final intent = ref.read(_intentProvider.notifier);
    final state = ref.watch(_intentProvider);
    ref.listen(
      editPrepFormEffectProvider,
      (previous, next) {
        if (next is ShowErrorSnackBar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.message)),
          );
        }
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _ingredientSearchKeywordEditingController,
          decoration: const InputDecoration(hintText: '재료명'),
          onChanged: intent.updateIngredientSearchSuggestions,
          onFieldSubmitted: intent.submitIngredientName,
          onTapOutside: _onIngredientSearchFormFieldTapOutside,
        ),
        _IngredientSearchBox(
          suggestions: state.ingredientSearchSuggestions,
          onSelected: intent.selectIngredient,
        ),
        if (state.ingredient != null)
          _AmountUnitField(
            initialValue: state.amountValue.toInt().toString(),
            amountUnit: state.amountUnit,
            onValueChanged: intent.changeAmountValue,
            onUnitChanged: intent.changeAmountUnit,
          ),
        if (state.isValid)
          TextButton(
            onPressed: _onSubmitButtonPressed,
            child: const Text('추가하기'),
          ),
      ],
    );
  }

  void _onSubmitButtonPressed() {
    final state = ref.read(_intentProvider);
    final amount = state.amountUnit?.toAmount(state.amountValue);
    final ingredient = state.ingredient;
    if (amount == null || ingredient == null) return;

    widget.onSubmitted?.call(Prep(amount: amount, ingredient: ingredient));
  }

  void _onIngredientSearchFormFieldTapOutside(PointerDownEvent event) {
    FocusScope.of(context).unfocus();
    _ingredientSearchKeywordEditingController.text =
        ref.read(_intentProvider).ingredient?.name ?? '';
  }
}

class _IngredientSearchBox extends ConsumerWidget {
  const _IngredientSearchBox({
    this.suggestions = const [],
    this.onSelected,
  });

  final List<Ingredient> suggestions;

  final ValueChanged<Ingredient>? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        Expanded(
          child: _AmountUnitSelector(
            amountUnit: amountUnit,
            onChanged: onUnitChanged,
          ),
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
    return DropdownButtonFormField<AmountUnit>(
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
