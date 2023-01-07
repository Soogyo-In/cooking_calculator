part of 'model_mapper.dart';

extension RecipDataMapper on RecipeData {
  IndexedRecipe toRecipe() {
    final directions = this.directions.map(
      (directionData) {
        final countByIngredientId = <int, Count>{};
        final massByIngredientId = <int, Mass>{};
        final volumeByIngredientId = <int, Volume>{};
        final ingredientAmounts = directionData.ingredients ?? [];
        for (final ingredientAmount in ingredientAmounts) {
          final ingredientId = ingredientAmount.ingredientId;
          final amount = ingredientAmount.toAmount();

          if (amount is Count) countByIngredientId[ingredientId] = amount;
          if (amount is Mass) massByIngredientId[ingredientId] = amount;
          if (amount is Volume) volumeByIngredientId[ingredientId] = amount;
        }

        return Direction(
          description: directionData.description,
          temperature: directionData.temperature?.toTemperature(),
          time: Duration(seconds: directionData.timeInSeconds ?? 0),
          countByIngredientId: countByIngredientId,
          massByIngredientId: massByIngredientId,
          volumeByIngredientId: volumeByIngredientId,
        );
      },
    ).toList();

    return IndexedRecipe(
      directions: directions,
      name: name,
      description: description ?? '',
      id: id,
      servings: servings,
    );
  }
}
