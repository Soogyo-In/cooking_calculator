import 'package:cooking_calulator/model/model.dart';

Map<Ingredient, T> calculateAmountByIngredientServingsFor<T extends Amount>({
  required Map<Ingredient, T> amountByIngredient,
  required int originServings,
  required int toServings,
}) {
  final calculated = <Ingredient, T>{};

  amountByIngredient.forEach((ingredient, amount) {
    calculated[ingredient] = (amount * (toServings / originServings)) as T;
  });

  return calculated;
}
