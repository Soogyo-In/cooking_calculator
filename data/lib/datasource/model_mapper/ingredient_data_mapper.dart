part of 'model_mapper.dart';

extension IngredientDataMapper on IngredientData {
  IndexedIngredient toIngredient() {
    return IndexedIngredient(
      name: name,
      description: description ?? '',
      id: id,
    );
  }
}
