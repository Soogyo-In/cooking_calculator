part of 'repository.dart';

class CachedRecipeRepository extends StateNotifier<Map<int, IndexedRecipe>>
    implements RecipeRepository {
  final RecipeDatasource _recipeDataSource;

  CachedRecipeRepository(RecipeDatasource recipeDataSource)
      : _recipeDataSource = recipeDataSource,
        super({});

  @override
  Future<IndexedRecipe> addRecipe(Recipe recipe) async {
    final indexedRecipe = await _recipeDataSource.addRecipe(recipe);
    state[indexedRecipe.id] = indexedRecipe;

    return indexedRecipe;
  }

  @override
  Future<void> deleteRecipe(int id) async {
    await _recipeDataSource.deleteRecipe(id);
    state.remove(id);
  }

  @override
  Future<List<IndexedRecipe>> getAllRecipes() async {
    if (state.isNotEmpty) return state.values.toList();

    final recipes = await _recipeDataSource.getAllRecipes();
    state = {for (final recipe in recipes) recipe.id: recipe};

    return recipes;
  }

  @override
  Future<IndexedRecipe> getRecipe(int id) async {
    final recipe = state[id] ?? await _recipeDataSource.getRecipe(id);

    state.putIfAbsent(id, () => recipe);

    return recipe;
  }

  @override
  Future<IndexedRecipe> updateRecipe(IndexedRecipe recipe) async {
    final updatedRecipe = await _recipeDataSource.updateRecipe(recipe);
    state[updatedRecipe.id] = updatedRecipe;

    return updatedRecipe;
  }
}
