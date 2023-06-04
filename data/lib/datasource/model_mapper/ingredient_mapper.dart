part of 'model_mapper.dart';

extension DataIngredientMapper on Ingredient {
  domain.Ingredient toDomainModel() => domain.Ingredient(
        name: name,
        description: description ?? '',
      );
}

extension DomainIngredientMapper on domain.Ingredient {
  Ingredient toDataModel({Id? id}) => Ingredient(
        id: id ?? Isar.autoIncrement,
        description: description,
        name: name,
      );
}
