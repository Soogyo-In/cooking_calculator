part of 'mapper.dart';

extension DataIngredientMapper on Ingredient {
  domain.StoredIngredient toDomainModel() => domain.StoredIngredient(
        id: id,
        name: name,
        description: description,
      );
}

extension DomainIngredientMapper on domain.Ingredient {
  Ingredient toDataModel({Id id = Isar.autoIncrement}) => Ingredient(
        id: id,
        description: description,
        name: name,
      );
}
