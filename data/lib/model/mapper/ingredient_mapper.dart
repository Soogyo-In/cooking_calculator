part of 'mapper.dart';

extension DataIngredientMapper on Ingredient {
  domain.StoredIngredient toDomainModel() => domain.StoredIngredient(
        id: id,
        name: name,
        description: description,
      );
}

extension DomainIngredientMapper on domain.Ingredient {
  Ingredient toDataModel() => Ingredient(
        id: Isar.autoIncrement,
        description: description,
        name: name,
      );
}
