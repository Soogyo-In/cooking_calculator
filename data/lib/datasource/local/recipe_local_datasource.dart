part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  const RecipeLocalDatasource(this.databasePath);

  final String databasePath;

  @override
  Future<IndexedRecipe> addRecipe(Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<IndexedRecipe> getRecipe(Id id) async {
    final isar = await _openDatabase([RecipeDataSchema]);
    final recipeData = await isar.recipeDatas.get(id);

    await isar.close();

    if (recipeData == null) throw DataNotFoundException();

    return recipeData.toRecipe();
  }

  @override
  Future<List<IndexedRecipe>> getAllRecipes() async {
    final isar = await _openDatabase([RecipeDataSchema]);
    final recipeDatas = await isar.recipeDatas.where().findAll();

    await isar.close();

    return recipeDatas.map((recipeData) => recipeData.toRecipe()).toList();
  }

  @override
  Future<IndexedRecipe> updateRecipe(IndexedRecipe recipe) =>
      _upsertRecipe(recipe);

  @override
  Future<void> deleteRecipe(Id id) async {
    final isar = await _openDatabase([RecipeDataSchema]);
    await isar.writeTxn(() => isar.recipeDatas.delete(id));
    await isar.close();
  }

  @override
  Future<IndexedIngredient> addIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<IndexedIngredient> getIngredient(Id id) async {
    final isar = await _openDatabase([IngredientDataSchema]);
    final ingredientData = await isar.ingredientDatas.get(id);

    await isar.close();

    if (ingredientData == null) throw DataNotFoundException();

    return ingredientData.toIngredient();
  }

  @override
  Future<List<IndexedIngredient>> getAllIngredients() async {
    final isar = await _openDatabase([IngredientDataSchema]);
    final ingredientDatas = await isar.ingredientDatas.where().findAll();

    await isar.close();

    return ingredientDatas
        .map((ingredientData) => ingredientData.toIngredient())
        .toList();
  }

  @override
  Future<IndexedIngredient> updateIngredient(IndexedIngredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<void> deleteIngredient(Id id) async {
    final isar = await _openDatabase([IngredientDataSchema]);
    await isar.writeTxn(() => isar.ingredientDatas.delete(id));
    await isar.close();
  }

  Future<IndexedRecipe> _upsertRecipe(Recipe recipe) async {
    final isar = await _openDatabase([RecipeDataSchema]);
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
            ..unit = amount.toMatterUnit()
            ..value = amount.value;
        },
      ).toList();

      directionData.add(
        DirectionData()
          ..description = direction.description
          ..ingredients = ingredientData
          ..temperature = direction.temperature?.toTemperatureData()
          ..timeInSeconds = direction.time.inSeconds,
      );
    }

    final id = await isar.writeTxn(() {
      final id = recipe.map(
        (value) => Isar.autoIncrement,
        indexed: (value) => value.id,
      );
      return isar.recipeDatas.put(
        RecipeData(id: id)
          ..description = recipe.description
          ..directions = directionData
          ..name = recipe.name
          ..servings = recipe.servings,
      );
    });

    await isar.close();

    return recipe.map(
      (value) => IndexedRecipe(
        id: id,
        name: recipe.name,
        directions: recipe.directions,
        description: recipe.description,
        servings: recipe.servings,
      ),
      indexed: (value) => value,
    );
  }

  Future<IndexedIngredient> _upsertIngredient(Ingredient ingredient) async {
    final isar = await _openDatabase([IngredientDataSchema]);
    final id = await isar.writeTxn(() {
      final id = ingredient.map(
        (value) => Isar.autoIncrement,
        indexed: (value) => value.id,
      );
      return isar.ingredientDatas.put(
        IngredientData(id: id)
          ..description = ingredient.description
          ..name = ingredient.name,
      );
    });

    await isar.close();

    return ingredient.map(
      (value) => IndexedIngredient(
        id: id,
        name: ingredient.name,
        description: ingredient.description,
      ),
      indexed: (value) => value,
    );
  }

  Future<Isar> _openDatabase(List<CollectionSchema> schemas) => Isar.open(
        schemas,
        directory: databasePath,
      );
}
