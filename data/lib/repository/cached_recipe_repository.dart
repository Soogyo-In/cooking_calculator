part of 'repository.dart';

typedef RecipeTable = Map<int, IndexedRecipe>;

class CachedRecipeRepository extends StateNotifier<RecipeTable>
    implements RecipeRepository {
  final RecipeDatasource _recipeDataSource;

  CachedRecipeRepository({
    required RecipeDatasource recipeDatasource,
    RecipeTable initialCache = const {},
  })  : _recipeDataSource = recipeDatasource,
        super(initialCache);

  @override
  Future<IndexedRecipe> addRecipe(Recipe recipe) async {
    final indexedRecipe = await _recipeDataSource.addRecipe(recipe);

    state = Map.from(state)..[indexedRecipe.id] = indexedRecipe;

    return indexedRecipe;
  }

  @override
  Future<void> deleteRecipe(int id) async {
    await _recipeDataSource.deleteRecipe(id);

    state = Map.from(state)..remove(id);
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

    state = Map.from(state)..putIfAbsent(id, () => recipe);

    return recipe;
  }

  @override
  Future<IndexedRecipe> updateRecipe(IndexedRecipe recipe) async {
    final updatedRecipe = await _recipeDataSource.updateRecipe(recipe);

    state = Map.from(state)..[updatedRecipe.id] = updatedRecipe;

    return updatedRecipe;
  }
}
