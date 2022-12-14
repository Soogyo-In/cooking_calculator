part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  @override
  Future<domain.Recipe> addRecipe(domain.Recipe recipe) =>
      _upsertRecipe(recipe);

  @override
  Future<domain.Recipe> getRecipe(Id id) async {
    final isar = await Isar.open([RecipeSchema, IngredientSchema]);
    final recipeData = await isar.recipes.get(id);
    if (recipeData == null) throw DataNotFoundException();

    final directions = recipeData.directions.map(
      (directionData) {
        final temperatureData = directionData.temperature;
        domain.Temperature? temperature;
        if (temperatureData != null) {
          if (temperatureData.unit.isCelsius) {
            temperature = domain.Celsius(temperatureData.value);
          }
          if (temperatureData.unit.isFahrenheit) {
            temperature = domain.Fahrenheit(temperatureData.value);
          }
        }

        final countByIngredientId = <int, domain.Count>{};
        final massByIngredientId = <int, domain.Mass>{};
        final volumeByIngredientId = <int, domain.Volume>{};
        final ingredientAmounts = directionData.ingredients ?? [];
        for (final ingredientAmount in ingredientAmounts) {
          final ingredientId = ingredientAmount.ingredientId;
          final amount = ingredientAmount.unit.toAmount(ingredientAmount.value);
          if (amount is domain.Count) {
            countByIngredientId[ingredientId] = amount;
          }
          if (amount is domain.Mass) {
            massByIngredientId[ingredientId] = amount;
          }
          if (amount is domain.Volume) {
            volumeByIngredientId[ingredientId] = amount;
          }
        }

        return domain.Direction(
          description: directionData.description,
          temperature: temperature,
          time: Duration(seconds: directionData.timeInSeconds ?? 0),
          countByIngredientId: countByIngredientId,
          massByIngredientId: massByIngredientId,
          volumeByIngredientId: volumeByIngredientId,
        );
      },
    ).toList();

    await isar.close();

    return domain.Recipe(
      directions: directions,
      name: recipeData.name,
      description: recipeData.description ?? '',
      id: recipeData.id,
      servings: recipeData.servings,
    );
  }

  @override
  Future<void> updateRecipe(domain.Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<void> deleteRecipe(Id id) async {
    final isar = await Isar.open([RecipeSchema]);
    await isar.recipes.delete(id);
    isar.close();
  }

  @override
  Future<domain.Ingredient> addIngredient(domain.Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<domain.Ingredient> getIngredient(Id id) async {
    final isar = await Isar.open([IngredientSchema]);
    final ingredient = await isar.ingredients.get(id);
    if (ingredient == null) throw DataNotFoundException();

    await isar.close();

    return domain.Ingredient(
      name: ingredient.name,
      description: ingredient.description ?? '',
      id: ingredient.id,
    );
  }

  @override
  Future<void> updateIngredient(domain.Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<void> deleteIngredient(Id id) async {
    final isar = await Isar.open([IngredientSchema]);
    await isar.ingredients.delete(id);
    await isar.close();
  }

  Future<domain.Recipe> _upsertRecipe(domain.Recipe recipe) async {
    final isar = await Isar.open([RecipeSchema, IngredientSchema]);
    final directionData = <Direction>[];
    for (final direction in recipe.directions) {
      final amountByIngredientId = {
        ...direction.massByIngredientId,
        ...direction.volumeByIngredientId,
        ...direction.countByIngredientId,
      };
      final ingredientData = amountByIngredientId.entries.map(
        (entry) {
          final ingredientId = entry.key;
          final amount = entry.value;
          return IngredientAmount()
            ..ingredientId = ingredientId
            ..unit = MatterUnit.fromAmount(amount)
            ..value = amount.value;
        },
      ).toList();

      Temperature? temperatureData;
      final temperature = direction.temperature;
      if (temperature != null) {
        temperatureData = TemperatureUnit.fromTemperature(temperature);
      }

      directionData.add(
        Direction()
          ..description = direction.description
          ..ingredients = ingredientData
          ..temperature = temperatureData
          ..timeInSeconds = direction.time.inMilliseconds,
      );
    }

    final id = await isar.recipes.put(
      Recipe(id: recipe.id)
        ..description = recipe.description
        ..directions = directionData
        ..name = recipe.name
        ..servings = recipe.servings,
    );

    await isar.close();

    return recipe.copyWith(id: id);
  }

  Future<domain.Ingredient> _upsertIngredient(
    domain.Ingredient ingredient,
  ) async {
    final isar = await Isar.open([IngredientSchema]);
    final id = await isar.ingredients.put(
      Ingredient(id: ingredient.id)
        ..description = ingredient.description
        ..name = ingredient.name,
    );

    await isar.close();

    return ingredient.copyWith(id: id);
  }
}
