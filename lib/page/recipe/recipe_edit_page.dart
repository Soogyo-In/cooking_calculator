import 'package:cooking_calulator/widget/widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeEditPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _EditableIngredientList extends StatelessWidget {
  final Map<Ingredient, Amount> _amountByIngredient;

  const _EditableIngredientList(Map<Ingredient, Amount> amountByIngredient)
      : _amountByIngredient = amountByIngredient;

  @override
  Widget build(BuildContext context) {
    final ingredientList = <Widget>[];

    _amountByIngredient.forEach((ingredient, count) {
      final rounded = count.roundedAt(2);

      if (rounded.value == 0.0) {
        ingredientList.add(Text(ingredient.name));
        return;
      }

      ingredientList.add(Row(
        children: [
          Expanded(
            child: RealNumberInput(
              decoration: InputDecoration(labelText: ingredient.name),
              controller: TextEditingController(text: rounded.value.toString()),
            ),
          ),
          Text(rounded.symbol),
        ],
      ));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientList,
    );
  }
}
