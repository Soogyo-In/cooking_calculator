part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  RecipeLocalDatasource(this.databasePath);

  final String databasePath;

  @override
  Future<void> addRecipe(domain.Recipe recipe) async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );

    await _upsertRecipe(isar: isar, recipe: recipe);

    await isar.close();
  }

  @override
  Future<domain.Recipe> getRecipe(Id id) async {
    final isar = await Isar.open(
      [RecipeSchema],
      directory: databasePath,
    );
    final recipe = await isar.recipes.get(id);

    await isar.close();

    if (recipe == null) throw DataNotFoundException();

    final ingredients = await isar.ingredients.getAll(
      recipe.preps.map((prep) => prep.ingredientId).toList(),
    );

    if (ingredients.contains(null)) throw DataNotFoundException();

    final ingredientById = {
      for (final ingredient in ingredients) ingredient!.id: ingredient
    };

    final directions = recipe.directions.map((direction) {
      final preps = direction.preps
              ?.map((prep) => prep.toDomainModel(
                    ingredientById[prep.ingredientId]!.toDomainModel(),
                  ))
              .toList() ??
          [];

      return domain.Direction(
        description: direction.description,
        preps: preps,
        temperature: direction.temperature?.toDomainModel(),
        time: Duration(seconds: direction.timeInSeconds ?? 0),
      );
    }).toList();

    return domain.Recipe(
      directions: directions,
      name: recipe.name,
      description: recipe.description ?? '',
      servings: recipe.servings,
    );
  }

  @override
  Future<List<domain.Recipe>> getAllRecipes() async {
    final isar = await Isar.open(
      [RecipeSchema],
      directory: databasePath,
    );
    final recipes = await isar.recipes.where().findAll();

    await isar.close();

    final ingredients = await isar.ingredients.getAll(
      recipes
          .expand((recipe) => recipe.preps)
          .map((prep) => prep.ingredientId)
          .toList(),
    );

    if (ingredients.contains(null)) throw DataNotFoundException();

    final ingredientById = {
      for (final ingredient in ingredients) ingredient!.id: ingredient
    };

    return recipes.map((recipe) {
      final directions = recipe.directions.map((direction) {
        final preps = direction.preps
                ?.map((prep) => prep.toDomainModel(
                      ingredientById[prep.ingredientId]!.toDomainModel(),
                    ))
                .toList() ??
            [];

        return domain.Direction(
          description: direction.description,
          preps: preps,
          temperature: direction.temperature?.toDomainModel(),
          time: Duration(seconds: direction.timeInSeconds ?? 0),
        );
      }).toList();

      return domain.Recipe(
        directions: directions,
        name: recipe.name,
        description: recipe.description ?? '',
        servings: recipe.servings,
      );
    }).toList();
  }

  @override
  Future<void> updateRecipe({
    required Id id,
    required domain.Recipe recipe,
  }) async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );

    await _upsertRecipe(isar: isar, id: id, recipe: recipe);

    await isar.close();
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
  Future<void> addIngredient(domain.Ingredient ingredient) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    await _upsertIngredient(isar: isar, ingredient: ingredient);

    await isar.close();
  }

  @override
  Future<domain.Ingredient> getIngredient(Id id) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );
    final ingredientData = await isar.ingredients.get(id);

    await isar.close();

    if (ingredientData == null) throw DataNotFoundException();

    return ingredientData.toDomainModel();
  }

  @override
  Future<List<domain.Ingredient>> getAllIngredients() async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );
    final ingredients = await isar.ingredients.where().findAll();

    await isar.close();

    return ingredients
        .map((ingredientData) => ingredientData.toDomainModel())
        .toList();
  }

  @override
  Future<void> updateIngredient({
    required Id id,
    required domain.Ingredient ingredient,
  }) async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    await _upsertIngredient(isar: isar, id: id, ingredient: ingredient);

    await isar.close();
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

  Future<void> _upsertRecipe({
    required Isar isar,
    Id? id,
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

      return Direction()
        ..description = direction.description
        ..preps = preps
        ..temperature = direction.temperature?.toDataModel()
        ..timeInSeconds = direction.time.inSeconds;
    }).toList();

    await isar.writeTxn(() => isar.recipes.put(
          Recipe(id: id ?? Isar.autoIncrement)
            ..description = recipe.description
            ..directions = directions
            ..name = recipe.name
            ..servings = recipe.servings,
        ));
  }

  Future<void> _upsertIngredient({
    required Isar isar,
    Id? id,
    required domain.Ingredient ingredient,
  }) async {
    await isar.writeTxn(() {
      return isar.ingredients.put(
        Ingredient(id: id ?? Isar.autoIncrement)
          ..description = ingredient.description
          ..name = ingredient.name,
      );
    });
  }
}
