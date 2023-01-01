part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  @override
  Future<Recipe> addRecipe(Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<Recipe> getRecipe(Id id) async {
    final isar = await Isar.open([RecipeDataSchema]);
    final recipeData = await isar.recipeDatas.get(id);

    await isar.close();

    if (recipeData == null) throw DataNotFoundException();

    return recipeData.toRecipe();
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final isar = await Isar.open([RecipeDataSchema]);
    final recipeDatas = await isar.recipeDatas.where().findAll();

    await isar.close();

    return recipeDatas.map((recipeData) => recipeData.toRecipe()).toList();
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<void> deleteRecipe(Id id) async {
    final isar = await Isar.open([RecipeDataSchema]);
    await isar.writeTxn(() => isar.recipeDatas.delete(id));
    await isar.close();
  }

  @override
  Future<Ingredient> addIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<Ingredient> getIngredient(Id id) async {
    final isar = await Isar.open([IngredientDataSchema]);
    final ingredientData = await isar.ingredientDatas.get(id);

    await isar.close();

    if (ingredientData == null) throw DataNotFoundException();

    return ingredientData.toIngredient();
  }

  @override
  Future<List<Ingredient>> getAllIngredients() async {
    final isar = await Isar.open([IngredientDataSchema]);
    final ingredientDatas = await isar.ingredientDatas.where().findAll();

    await isar.close();

    return ingredientDatas
        .map((ingredientData) => ingredientData.toIngredient())
        .toList();
  }

  @override
  Future<Ingredient> updateIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<void> deleteIngredient(Id id) async {
    final isar = await Isar.open([IngredientDataSchema]);
    await isar.writeTxn(() => isar.ingredientDatas.delete(id));
    await isar.close();
  }

  Future<Recipe> _upsertRecipe(Recipe recipe) async {
    final isar = await Isar.open([RecipeDataSchema]);
    final directionData = <DirectionData>[];
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
          return IngredientAmountData()
            ..ingredientId = ingredientId
            ..unit = IngredientAmountMapper.fromAmount(amount)
            ..value = amount.value;
        },
      ).toList();

      directionData.add(
        DirectionData()
          ..description = direction.description
          ..ingredients = ingredientData
          ..temperature = direction.temperature?.toTemperature()
          ..timeInSeconds = direction.time.inSeconds,
      );
    }

    final id = await isar.writeTxn(() {
      return isar.recipeDatas.put(
        RecipeData(id: recipe.id ?? Isar.autoIncrement)
          ..description = recipe.description
          ..directions = directionData
          ..name = recipe.name
          ..servings = recipe.servings,
      );
    });

    await isar.close();

    return recipe.copyWith(id: id);
  }

  Future<Ingredient> _upsertIngredient(
    Ingredient ingredient,
  ) async {
    final isar = await Isar.open([IngredientDataSchema]);
    final id = await isar.writeTxn(() {
      return isar.ingredientDatas.put(
        IngredientData(id: ingredient.id ?? Isar.autoIncrement)
          ..description = ingredient.description
          ..name = ingredient.name,
      );
    });

    await isar.close();

    return ingredient.copyWith(id: id);
  }
}
