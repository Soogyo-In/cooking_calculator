part of 'model_mapper.dart';

extension RecipDataMapper on RecipeData {
  Recipe toRecipe({
    required Map<int, IngredientData> ingredientById,
  }) {
    final directions = this.directions.map((direction) {
      final preps = direction.preps?.map((prep) {
            final ingredient =
                ingredientById[prep.ingredientId]!.toIngredient();

            return Prep(
              ingredient: ingredient,
              amount: prep.getAmount(),
            );
          }).toList() ??
          [];

      return Direction(
        description: direction.description,
        preps: preps,
        temperature: direction.temperature?.toTemperature(),
        time: Duration(seconds: direction.timeInSeconds ?? 0),
      );
    }).toList();

    return Recipe(
      id: id,
      name: name,
      directions: directions,
      description: description ?? '',
      servings: servings,
    );
  }
}
