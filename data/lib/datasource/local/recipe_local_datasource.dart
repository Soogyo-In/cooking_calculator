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
          .map((prep) => prep.toDomainModel(ingredientById[prep.ingredientId]!))
          .toList();

      return domain.Direction(
        description: direction.description,
        preps: preps,
        cookingTemperature: direction.cookingTemperature?.toDomainModel(),
        cookingTime: Duration(seconds: direction.cookingTimeInSeconds),
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
  Future<List<domain.StoredRecipe>> searchRecipes({
    int page = 0,
    int size = 0,
    String name = '',
    List<Id> ingredientIds = const [],
    Duration? cookingTime,
  }) async {
    final isar = await Isar.open(
      [RecipeSchema, IngredientSchema],
      directory: databasePath,
    );

    final recipes = await isar.recipes
        .where()
        .optional(
          cookingTime != null,
          (q) => q.filter().cookingTimeInSecondsLessThan(
                cookingTime!.inSeconds,
                include: true,
              ),
        )
        .optional(ingredientIds.isNotEmpty, (q) {
          var ingredientFilter = q.ingredientIdsElementEqualTo(
            ingredientIds.first,
          );
          for (final ingredientId in ingredientIds.skip(1)) {
            ingredientFilter = ingredientFilter.ingredientIdsElementEqualTo(
              ingredientId,
            );
          }
          return ingredientFilter;
        })
        .optional(name.isNotEmpty, (q) => q.nameWordsElementStartsWith(name))
        .offset(page * size)
        .optional(size > 0, (q) => q.limit(size))
        .findAll();
    final ingredients = await isar.ingredients
        .getAll(recipes.expand((recipe) => recipe.ingredientIds).toList());

    await isar.close();

    return recipes
        .map((recipe) => recipe.toDomainModel(ingredients.nonNulls))
        .toList();
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
                  ingredientById[prep.ingredientId]!,
                ))
            .toList();

        return domain.Direction(
          description: direction.description,
          preps: preps,
          cookingTemperature: direction.cookingTemperature?.toDomainModel(),
          cookingTime: Duration(seconds: direction.cookingTimeInSeconds),
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

    return ingredient.toDomainModel();
  }

  @override
  Future<List<domain.StoredIngredient>> getAllIngredients() async {
    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );
    final ingredients = await isar.ingredients.where().findAll();

    await isar.close();

    return ingredients.map((ingredient) => ingredient.toDomainModel()).toList();
  }

  @override
  Future<List<domain.StoredIngredient>> searchIngredients(String name) async {
    if (name.isEmpty) return [];

    final isar = await Isar.open(
      [IngredientSchema],
      directory: databasePath,
    );

    final ingredients = await isar.ingredients
        .where()
        .nameWordsElementStartsWith(name)
        .findAll();

    await isar.close();

    return ingredients.map((ingredient) => ingredient.toDomainModel()).toList();
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

    ingredientIdByName.addAll(Map.fromIterables(
      ingredientsToAdd.map((ingredient) => ingredient.name),
      newIngredientIds,
    ));

    final directions = recipe.directions.map((direction) {
      final preps = direction.preps
          .map((prep) {
            final ingredient = ingredientIdByName[prep.ingredient.name];
            if (ingredient == null) return null;
            return prep.toDataModel(ingredient);
          })
          .nonNulls
          .toList();

      return Direction(
        description: direction.description,
        preps: preps,
        cookingTemperature: direction.cookingTemperature?.toDataModel(),
        cookingTimeInSeconds: direction.cookingTime.inSeconds,
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
