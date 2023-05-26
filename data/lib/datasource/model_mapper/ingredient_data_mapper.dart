part of 'model_mapper.dart';

extension IngredientDataMapper on IngredientData {
  Ingredient toIngredient() {
    return Ingredient(
      name: name,
      description: description ?? '',
      id: id,
    );
  }
}
