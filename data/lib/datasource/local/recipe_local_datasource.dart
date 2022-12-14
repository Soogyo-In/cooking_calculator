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

    final getIngredients = recipeData.directions
        .expand((directionData) => directionData.ingredients ?? [])
        .map((ingredient) => isar.ingredients.get(ingredient.id));
    final ingredientDataByIds = <int, domain.Ingredient>{};
    final ingredientData = await Future.wait(getIngredients);
    for (final ingredient in ingredientData) {
      if (ingredient == null) throw DataNotFoundException();
      ingredientDataByIds[ingredient.id] = domain.Ingredient(
        name: ingredient.name,
        description: ingredient.description ?? '',
        id: ingredient.id,
      );
    }

    final directions = recipeData.directions.map(
      (direction) {
        final temperatureData = direction.temperature;
        domain.Temperature? temperature;
        if (temperatureData != null) {
          if (temperatureData.unit.isCelsius) {
            temperature = domain.Celsius(temperatureData.value);
          }
          if (temperatureData.unit.isFahrenheit) {
            temperature = domain.Fahrenheit(temperatureData.value);
          }
        }

        final countByIngredient = <domain.Ingredient, domain.Count>{};
        final massByIngredient = <domain.Ingredient, domain.Mass>{};
        final volumeByIngredient = <domain.Ingredient, domain.Volume>{};
        final ingredients = direction.ingredients ?? [];
        for (final ingredientData in ingredients) {
          final ingredient = ingredientDataByIds[ingredientData.id];
          if (ingredient == null) throw DataNotFoundException();

          final amount = ingredientData.unit.toAmount(ingredientData.value);
          if (amount is domain.Count) countByIngredient[ingredient] = amount;
          if (amount is domain.Mass) massByIngredient[ingredient] = amount;
          if (amount is domain.Volume) volumeByIngredient[ingredient] = amount;
        }

        return domain.Direction(
          description: direction.description,
          temperature: temperature,
          time: Duration(seconds: direction.timeInSeconds ?? 0),
          countByIngredient: countByIngredient,
          massByIngredient: massByIngredient,
          volumeByIngredient: volumeByIngredient,
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
      final amountByIngredient = {
        ...direction.massByIngredient,
        ...direction.volumeByIngredient,
        ...direction.countByIngredient,
      };
      final ingredientData = <IngredientAmount>[];
      final amountByPutIngredient = amountByIngredient.map(
        (ingredient, amount) => MapEntry(
          amount,
          isar.ingredients.put(
            Ingredient(id: ingredient.id)
              ..description = ingredient.description
              ..name = ingredient.name,
          ),
        ),
      );

      final newIngredients = await Future.wait(
        amountByPutIngredient.entries.map(
          (entry) {
            final amount = entry.key;
            final putIngredient = entry.value;

            return putIngredient.then(
              (id) => IngredientAmount()
                ..id = id
                ..unit = MatterUnit.fromAmount(amount)
                ..value = amount.value,
            );
          },
        ),
      );

      ingredientData.addAll(newIngredients);

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