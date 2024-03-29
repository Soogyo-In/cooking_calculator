import 'package:cooking_calulator/model/model.dart';
import 'package:cooking_calulator/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _amountFactorProvider = StateProvider<double>((ref) => 1.0);
final _servingFamily =
    StateProvider.autoDispose.family<StateProvider<int>, int>(
  (ref, servings) => StateProvider<int>(
    (ref) => servings * ref.watch(_amountFactorProvider).round(),
  ),
);
final _volumeUnitFamily =
    StateProvider.autoDispose.family<StateProvider<VolumeUnit?>, VolumeUnit?>(
  (ref, volumeUnit) => StateProvider((ref) => volumeUnit),
);
final _massUnitFamily =
    StateProvider.autoDispose.family<StateProvider<MassUnit?>, MassUnit?>(
  (ref, massUnit) => StateProvider((ref) => massUnit),
);

class RecipePage extends ConsumerWidget {
  final Recipe recipe;
  final servingTextEditor = TextEditingController();

  RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servingsProvider = ref.watch(_servingFamily(recipe.servings));
    final servings = ref.watch(servingsProvider);
    final servingsString = servings.toString();
    servingTextEditor.value = servingTextEditor.value.copyWith(
      text: servingsString,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe editor')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(recipe.name),
            const SizedBox(height: 8.0),
            Text(recipe.description),
            const SizedBox(height: 8.0),
            IntegerInput(
              controller: servingTextEditor,
              decoration: const InputDecoration(
                label: Text('servings'),
              ),
              maxLength: 2,
              onChanged: (text) => _onChanged(text, ref, servingsProvider),
            ),
            if (recipe.time != Duration.zero) ...[
              const SizedBox(height: 8.0),
              TimeText(time: recipe.time),
            ],
            const SizedBox(height: 8.0),
            _IngredientList(Map.fromEntries([
              ...recipe.countByIngredient.entries,
              ...recipe.massByIngredient.entries,
              ...recipe.volumeByIngredient.entries,
            ])),
            const SizedBox(height: 8.0),
            ...recipe.directions.map(
              (direction) => Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _DirectionDetail(direction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChanged(
    String text,
    WidgetRef ref,
    StateProvider<int> servingsProvider,
  ) {
    if (text.isNotEmpty) {
      final servings = int.tryParse(text) ?? 0;
      ref.read(_amountFactorProvider.state).state =
          servings / ref.read(servingsProvider.state).state;
    }
  }
}

class _IngredientList extends ConsumerWidget {
  final Map<Ingredient, Amount> _amountByIngredient;

  const _IngredientList(Map<Ingredient, Amount> amountByIngredient)
      : _amountByIngredient = amountByIngredient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factor = ref.watch(_amountFactorProvider);
    final ingredientList = <Widget>[];

    _amountByIngredient.forEach((ingredient, amount) {
      final editedAmount = amount * factor;
      if (amount.roundedAt(2).value <= 0.0) {
        ingredientList.add(Text(ingredient.name));
        return;
      }
      Widget? unitConverter;

      if (editedAmount is Volume) {
        final volumeUnitProvider = ref.watch(
          _volumeUnitFamily(VolumeUnit.fromAmount(editedAmount)),
        );
        unitConverter = AmountField.volume(
          volume: editedAmount,
          unit: ref.watch(volumeUnitProvider),
          onValueChanged: (value) => _onAmountValueChanged(
            ref: ref,
            value: value,
            amount: amount,
          ),
          onUnitChanged: (unit) =>
              ref.read(volumeUnitProvider.state).state = unit,
        );
      }
      if (editedAmount is Mass) {
        final massUnitProvider = ref.watch(
          _massUnitFamily(MassUnit.fromAmount(editedAmount)),
        );
        unitConverter = AmountField.mass(
          mass: editedAmount,
          unit: ref.watch(massUnitProvider),
          onValueChanged: (value) => _onAmountValueChanged(
            ref: ref,
            value: value,
            amount: amount,
          ),
          onUnitChanged: (unit) =>
              ref.read(massUnitProvider.state).state = unit,
        );
      }

      if (unitConverter != null) {
        ingredientList.add(SizedBox(
          height: 22.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ingredient.name),
              unitConverter,
            ],
          ),
        ));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientList,
    );
  }

  void _onAmountValueChanged({
    required WidgetRef ref,
    required String value,
    required Amount amount,
  }) {
    ref.watch(_amountFactorProvider.state).state =
        double.parse(value) / amount.value;
  }
}

class _DirectionDetail extends StatelessWidget {
  final Direction direction;

  const _DirectionDetail(this.direction);

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IngredientList(Map.fromEntries([
          ...direction.countByIngredient.entries,
          ...direction.massByIngredient.entries,
          ...direction.volumeByIngredient.entries,
        ])),
        if (direction.time != Duration.zero) ...[
          const SizedBox(height: 8.0),
          TimeText(time: direction.time),
        ],
        const SizedBox(height: 8.0),
        Text(direction.description),
      ],
    );
  }
}
