part of 'local_datasource.dart';

class RecipeLocalDatasource implements RecipeDatasource {
  @override
  Future<Recipe> addRecipe(Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<Recipe> getRecipe(Id id) async {
    final isar = await Isar.open([RecipeDataSchema]);
    final recipeData = await isar.recipeDatas.get(id);
    if (recipeData == null) throw DataNotFoundException();

    final directions = recipeData.directions.map(
      (directionData) {
        final countByIngredientId = <int, Count>{};
        final massByIngredientId = <int, Mass>{};
        final volumeByIngredientId = <int, Volume>{};
        final amountSetterByType = {
          (Count): (ingredientId, amount) {
            countByIngredientId[ingredientId] = amount;
          },
          (Mass): (ingredientId, amount) {
            massByIngredientId[ingredientId] = amount;
          },
          (Volume): (ingredientId, amount) {
            volumeByIngredientId[ingredientId] = amount;
          },
        };
        final ingredientAmounts = directionData.ingredients ?? [];
        for (final ingredientAmount in ingredientAmounts) {
          final ingredientId = ingredientAmount.ingredientId;
          final amount = ingredientAmount.toAmount();
          amountSetterByType[amount.runtimeType]?.call(ingredientId, amount);
        }

        return Direction(
          description: directionData.description,
          temperature: directionData.temperature?.toDomainTemperature(),
          time: Duration(seconds: directionData.timeInSeconds ?? 0),
          countByIngredientId: countByIngredientId,
          massByIngredientId: massByIngredientId,
          volumeByIngredientId: volumeByIngredientId,
        );
      },
    ).toList();

    await isar.close();

    return Recipe(
      directions: directions,
      name: recipeData.name,
      description: recipeData.description ?? '',
      id: recipeData.id,
      servings: recipeData.servings,
    );
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<void> deleteRecipe(Id id) async {
    final isar = await Isar.open([RecipeDataSchema]);
    await isar.recipeDatas.delete(id);
    isar.close();
  }

  @override
  Future<Ingredient> addIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<Ingredient> getIngredient(Id id) async {
    final isar = await Isar.open([IngredientDataSchema]);
    final ingredient = await isar.ingredientDatas.get(id);
    if (ingredient == null) throw DataNotFoundException();

    await isar.close();

    return Ingredient(
      name: ingredient.name,
      description: ingredient.description ?? '',
      id: ingredient.id,
    );
  }

  @override
  Future<Ingredient> updateIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<void> deleteIngredient(Id id) async {
    final isar = await Isar.open([IngredientDataSchema]);
    await isar.ingredientDatas.delete(id);
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
          ..timeInSeconds = direction.time.inMilliseconds,
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
    final id = await isar.ingredientDatas.put(
      IngredientData(id: ingredient.id ?? Isar.autoIncrement)
        ..description = ingredient.description
        ..name = ingredient.name,
    );

    await isar.close();

    return ingredient.copyWith(id: id);
  }
}
