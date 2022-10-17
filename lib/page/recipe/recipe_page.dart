import 'package:cooking_calulator/model/model.dart';
import 'package:cooking_calulator/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _servingsProvider = StateProvider<int?>((ref) => null);

class RecipePage extends ConsumerWidget {
  final Recipe recipe;
  final servingTextEditor = TextEditingController();

  RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servings =
        ref.watch(_servingsProvider.state).state ?? recipe.servings;
    final ratio = servings / recipe.servings;
    final servingsString = servings.toString();
    servingTextEditor.value = TextEditingValue(
      text: servingsString,
      selection: TextSelection.collapsed(offset: servingsString.length),
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
              onChanged: (text) {
                if (text.isNotEmpty) {
                  ref.read(_servingsProvider.notifier).state =
                      int.tryParse(text);
                }
              },
            ),
            if (recipe.time != Duration.zero) ...[
              const SizedBox(height: 8.0),
              TimeText(time: recipe.time),
            ],
            const SizedBox(height: 8.0),
            _IngredientList(Map.fromEntries([
              ...recipe.getCountByIngredientWithRatio(ratio).entries,
              ...recipe.getMassByIngredientWithRatio(ratio).entries,
              ...recipe.getVolumeByIngredientWithRatio(ratio).entries,
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
                child: _DirectionDetail(direction, ratio),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientList extends StatelessWidget {
  final Map<Ingredient, Amount> _amountByIngredient;

  const _IngredientList(Map<Ingredient, Amount> amountByIngredient)
      : _amountByIngredient = amountByIngredient;

  @override
  Widget build(BuildContext context) {
    final ingredientList = <Widget>[];

    _amountByIngredient.forEach((ingredient, amount) {
      if (amount.roundedAt(2).value <= 0.0) {
        ingredientList.add(Text(ingredient.name));
        return;
      }
      Widget? unitConverter;

      if (amount is Volume) {
        unitConverter = UnitConverter.volume(volume: amount);
      }
      if (amount is Mass) {
        unitConverter = UnitConverter.mass(mass: amount);
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
}

class _DirectionDetail extends StatelessWidget {
  final Direction direction;
  final double servingRatio;

  const _DirectionDetail(this.direction, this.servingRatio);

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IngredientList(Map.fromEntries([
          ...direction.getCountByIngredientWithRatio(servingRatio).entries,
          ...direction.getMassByIngredientWithRatio(servingRatio).entries,
          ...direction.getVolumeByIngredientWithRatio(servingRatio).entries,
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
