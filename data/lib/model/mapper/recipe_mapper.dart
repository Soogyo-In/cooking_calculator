part of 'mapper.dart';

extension DataRecipeMapper on Recipe {
  domain.StoredRecipe toDomainModel(Iterable<Ingredient> ingredients) {
    final ingredientById = {
      for (final ingredient in ingredients) ingredient.id: ingredient
    };

    return domain.StoredRecipe(
      id: id,
      description: description,
      directions: directions
          .map((direction) => domain.Direction(
                description: direction.description,
                preps: direction.preps
                    .map((prep) {
                      final ingredient = ingredientById[prep.ingredientId];
                      if (ingredient == null) return null;

                      return prep.toDomainModel(ingredient);
                    })
                    .nonNulls
                    .toList(),
                cookingTemperature:
                    direction.cookingTemperature?.toDomainModel(),
                cookingTime: Duration(
                  seconds: direction.cookingTimeInSeconds,
                ),
              ))
          .toList(),
      name: name,
      servingUnit: servingUnit.toDomainModel(),
      servings: servings,
    );
  }
}

extension DomainRecipeMapper on domain.Recipe {
  Recipe toDataModel() {
    return Recipe(
      id: Isar.autoIncrement,
      name: name,
      description: description,
      servingUnit: servingUnit.toDataModel(),
      servings: servings,
      directions: directions
          .map((direction) => Direction(
                cookingTimeInSeconds: direction.cookingTime.inSeconds,
                description: direction.description,
                preps: direction.preps
                    .map((prep) => prep.toDataModel(Isar.autoIncrement))
                    .toList(),
                cookingTemperature: direction.cookingTemperature?.toDataModel(),
              ))
          .toList(),
    );
  }
}
