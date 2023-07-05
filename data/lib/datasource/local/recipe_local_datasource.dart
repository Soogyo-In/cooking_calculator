part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  RecipeLocalDatasource(this.databasePath);

  final String databasePath;

  @override
  Future<domain.StoredRecipe> addRecipe(domain.Recipe recipe) async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );

    final id = await _upsertRecipe(isar: isar, recipe: recipe);

    await isar.close();

    return recipe.withId(id);
  }

  @override
  Future<domain.StoredRecipe> getRecipe(Id id) async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );
    final recipe = await isar.recipes.get(id);

    if (recipe == null) {
      await isar.close();
      throw DataNotFoundException();
    }

    final ingredients = await isar.ingredients.getAll(
      recipe.preps.map((prep) => prep.ingredientId).toList(),
    );

    await isar.close();

    if (ingredients.contains(null)) throw DataNotFoundException();

    final ingredientById = {
      for (final ingredient in ingredients) ingredient!.id: ingredient
    };

    final directions = recipe.directions.map((direction) {
      final preps = direction.preps
          .map((prep) => prep.toDomainModel(
                ingredientById[prep.ingredientId]!.toDomainModel(),
              ))
          .toList();

      return domain.Direction(
        description: direction.description,
        preps: preps,
        temperature: direction.temperature?.toDomainModel(),
        time: Duration(seconds: direction.timeInSeconds),
      );
    }).toList();

    return domain.StoredRecipe(
      id: recipe.id,
      directions: directions,
      name: recipe.name,
      description: recipe.description,
      servings: recipe.servings,
    );
  }

  @override
  Future<List<domain.StoredRecipe>> getAllRecipes() async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );
    final recipes = await isar.recipes.where().findAll();
    final ingredients = await isar.ingredients.getAll(
      recipes
          .expand((recipe) => recipe.preps)
          .map((prep) => prep.ingredientId)
          .toList(),
    );

    await isar.close();

    if (ingredients.contains(null)) throw DataNotFoundException();

    final ingredientById = {
      for (final ingredient in ingredients) ingredient!.id: ingredient
    };

    return recipes.map((recipe) {
      final directions = recipe.directions.map((direction) {
        final preps = direction.preps
            .map((prep) => prep.toDomainModel(
                  ingredientById[prep.ingredientId]!.toDomainModel(),
                ))
            .toList();

        return domain.Direction(
          description: direction.description,
          preps: preps,
          temperature: direction.temperature?.toDomainModel(),
          time: Duration(seconds: direction.timeInSeconds),
        );
      }).toList();

      return domain.StoredRecipe(
        id: recipe.id,
        directions: directions,
        name: recipe.name,
        description: recipe.description,
        servings: recipe.servings,
      );
    }).toList();
  }

  @override
  Future<domain.StoredRecipe> updateRecipe({
    required Id id,
    required domain.Recipe recipe,
  }) async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );

    id = await _upsertRecipe(isar: isar, id: id, recipe: recipe);

    await isar.close();

    return recipe.withId(id);
  }

  @override
  Future<void> deleteRecipe(Id id) async {
    final isar = await Isar.open(
      [RecipeSchema],
      directory: databasePath,
    );

    await isar.writeTxn(() => isar.recipes.delete(id));

    await isar.close();
  }

  @override
  Future<domain.StoredIngredient> addIngredient(
    domain.Ingredient ingredient,
  ) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    final id = await _upsertIngredient(isar: isar, ingredient: ingredient);

    await isar.close();

    return ingredient.withId(id);
  }

  @override
  Future<domain.StoredIngredient> getIngredient(Id id) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );
    final ingredient = await isar.ingredients.get(id);

    await isar.close();

    if (ingredient == null) throw DataNotFoundException();

    return ingredient.toStoredModel(ingredient.id);
  }

  @override
  Future<List<domain.StoredIngredient>> getAllIngredients() async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );
    final ingredients = await isar.ingredients.where().findAll();

    await isar.close();

    return ingredients
        .map((ingredient) => ingredient.toStoredModel(ingredient.id))
        .toList();
  }

  @override
  Future<List<domain.StoredIngredient>> searchIngredients({
    String? name,
  }) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    final ingredients = await isar.ingredients
        .where()
        .optional(
          name != null,
          (q) => name == null ? q : q.nameWordsElementStartsWith(name),
        )
        .findAll();

    await isar.close();

    return ingredients
        .map((ingredient) => ingredient.toStoredModel(ingredient.id))
        .toList();
  }

  @override
  Future<domain.StoredIngredient> updateIngredient({
    required Id id,
    required domain.Ingredient ingredient,
  }) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    id = await _upsertIngredient(isar: isar, id: id, ingredient: ingredient);

    await isar.close();

    return ingredient.withId(id);
  }

  @override
  Future<void> deleteIngredient(Id id) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    await isar.writeTxn(() => isar.ingredients.delete(id));

    await isar.close();
  }

  Future<Id> _upsertRecipe({
    required Isar isar,
    Id id = Isar.autoIncrement,
    required domain.Recipe recipe,
  }) async {
    final currentIngredients = recipe.directions
        .expand((direction) => direction.preps)
        .map((prep) => prep.ingredient);

    final currentIngredientNames =
        currentIngredients.map((ingredient) => ingredient.name).toList();
    final ingredientQueryResults = await IngredientByIndex(isar.ingredients)
        .getAllByName(currentIngredientNames);

    final ingredientIdByName = Map.fromIterables(
      currentIngredientNames,
      ingredientQueryResults.map((ingredient) => ingredient?.id),
    );

    final ingredientsToAdd = currentIngredients
        .where((ingrdient) => ingredientIdByName[ingrdient.name] == null)
        .map((ingredient) => ingredient.toDataModel())
        .toList();
    final newIngredientIds = await isar.writeTxn(
      () => isar.ingredients.putAll(ingredientsToAdd),
    );

    newIngredientIds
        .zip(ingredientsToAdd.map((ingredient) => ingredient.name))
        .forEach((pair) {
      final ingredientId = pair.first;
      final ingredientName = pair.second;
      ingredientIdByName[ingredientName] = ingredientId;
    });

    final directions = recipe.directions.map((direction) {
      final preps = direction.preps
          .map((prep) => prep.toDataModel(
                ingredientIdByName[prep.ingredient.name]!,
              ))
          .toList();

      return Direction(
        description: direction.description,
        preps: preps,
        temperature: direction.temperature?.toDataModel(),
        timeInSeconds: direction.time.inSeconds,
      );
    }).toList();

    return isar.writeTxn(() => isar.recipes.put(Recipe(
          id: id,
          description: recipe.description,
          directions: directions,
          name: recipe.name,
          servings: recipe.servings,
        )));
  }

  Future<Id> _upsertIngredient({
    required Isar isar,
    Id id = Isar.autoIncrement,
    required domain.Ingredient ingredient,
  }) {
    return isar.writeTxn(() {
      return isar.ingredients.put(Ingredient(
        id: id,
        description: ingredient.description,
        name: ingredient.name,
      ));
    });
  }
}
