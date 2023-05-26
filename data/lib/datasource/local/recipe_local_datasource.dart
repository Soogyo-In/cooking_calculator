part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  const RecipeLocalDatasource(this.databasePath);

  final String databasePath;

  @override
  Future<Recipe> addRecipe(TransientRecipe recipe) => _upsertRecipe(recipe);

  @override
  Future<Recipe> getRecipe(Id id) async {
    final isar = await _openDatabase([RecipeDataSchema]);

    final recipe = await isar.recipeDatas.get(id);
    if (recipe == null) {
      await isar.close();
      throw DataNotFoundException();
    }

    final ingredientIds = recipe.ingredientIdSet.toList();
    final ingredientData = await isar.ingredientDatas.getAll(ingredientIds);
    if (ingredientData.contains(null)) {
      await isar.close();
      throw DataNotFoundException();
    }

    await isar.close();

    final ingredientById = {
      for (final ingredient in ingredientData.nonNulls)
        ingredient.id: ingredient
    };

    return recipe.toRecipe(ingredientById: ingredientById);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final isar = await _openDatabase([RecipeDataSchema]);

    final recipes = await isar.recipeDatas.where().findAll();
    final ingredientIds =
        recipes.expand((recipe) => recipe.ingredientIdSet).toSet().toList();
    final ingredientData = await isar.ingredientDatas.getAll(ingredientIds);
    if (ingredientData.contains(null)) {
      await isar.close();
      throw DataNotFoundException();
    }

    await isar.close();

    final ingredientById = {
      for (final ingredient in ingredientData.nonNulls)
        ingredient.id: ingredient
    };

    return recipes
        .map((recipe) => recipe.toRecipe(ingredientById: ingredientById))
        .toList();
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<void> deleteRecipe(Id id) async {
    final isar = await _openDatabase([RecipeDataSchema]);
    await isar.writeTxn(() => isar.recipeDatas.delete(id));
    await isar.close();
  }

  @override
  Future<Ingredient> addIngredient(TransientIngredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<Ingredient> getIngredient(Id id) async {
    final isar = await _openDatabase([IngredientDataSchema]);
    final ingredient = await isar.ingredientDatas.get(id);

    await isar.close();

    if (ingredient == null) throw DataNotFoundException();

    return ingredient.toIngredient();
  }

  @override
  Future<List<Ingredient>> getAllIngredients() async {
    final isar = await _openDatabase([IngredientDataSchema]);
    final ingredients = await isar.ingredientDatas.where().findAll();

    await isar.close();

    return ingredients.map((ingredient) => ingredient.toIngredient()).toList();
  }

  @override
  Future<Ingredient> updateIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<void> deleteIngredient(Id id) async {
    final isar = await _openDatabase([IngredientDataSchema]);
    await isar.writeTxn(() => isar.ingredientDatas.delete(id));
    await isar.close();
  }

  Future<Recipe> _upsertRecipe(TransientRecipe recipe) async {
    final isar = await _openDatabase([RecipeDataSchema]);

    final directions = recipe.directions.cast<Direction>().map((direction) {
      final preps = direction.preps.cast<Prep>().map((prep) {
        final ingredientId = prep.ingredient.id;
        final amount = prep.amount;
        return PrepData()
          ..ingredientId = ingredientId
          ..unit = amount.toMatterUnit()
          ..value = amount.value;
      }).toList();

      return DirectionData()
        ..description = direction.description
        ..preps = preps
        ..temperature = direction.temperature?.toTemperatureData()
        ..timeInSeconds = direction.time.inSeconds;
    }).toList();

    final id = await isar.writeTxn(() {
      final id = recipe.map(
        (value) => Isar.autoIncrement,
        indexed: (value) => value.id,
      );

      return isar.recipeDatas.put(
        RecipeData(id: id)
          ..description = recipe.description
          ..directions = directions
          ..name = recipe.name
          ..servings = recipe.servings,
      );
    });

    await isar.close();

    return recipe.map(
      (value) => Recipe(
        id: id,
        name: recipe.name,
        directions: recipe.directions,
        description: recipe.description,
        servings: recipe.servings,
      ),
      indexed: (value) => value,
    );
  }

  Future<Ingredient> _upsertIngredient(TransientIngredient ingredient) async {
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
      (value) => Ingredient(
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
