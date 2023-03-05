part of 'repository.dart';

typedef RecipeTable = Map<int, IndexedRecipe>;

class CachedRecipeRepository extends AsyncNotifier<RecipeTable>
    implements RecipeRepository {
  final _cache = <int, IndexedRecipe>{};

  RecipeDatasource get _recipeDataSource => ref.watch(recipeDatasourceProvider);

  @override
  FutureOr<RecipeTable> build() async {
    final recipes = await _recipeDataSource.getAllRecipes();
    for (final recipe in recipes) {
      _cache[recipe.id] = recipe;
    }
    return _cache;
  }

  @override
  Future<IndexedRecipe> addRecipe(Recipe recipe) async {
    state = const AsyncValue.loading();

    late final IndexedRecipe indexedRecipe;
    state = await AsyncValue.guard(() async {
      indexedRecipe = await _recipeDataSource.addRecipe(recipe);
      return _cache..[indexedRecipe.id] = indexedRecipe;
    });

    return indexedRecipe;
  }

  @override
  Future<void> deleteRecipe(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _recipeDataSource.deleteRecipe(id);
      return _cache..remove(id);
    });
  }

  @override
  Future<List<IndexedRecipe>> getAllRecipes() async {
    if (_cache.isNotEmpty) return Future.sync(() => _cache.values.toList());

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final recipes = await _recipeDataSource.getAllRecipes();
      for (final recipe in recipes) {
        _cache[recipe.id] = recipe;
      }
      return _cache;
    });

    return _cache.values.toList();
  }

  @override
  Future<IndexedRecipe> getRecipe(int id) async {
    final cache = _cache[id];
    if (cache != null) return Future.sync(() => cache);

    state = const AsyncValue.loading();

    late final IndexedRecipe recipe;
    state = await AsyncValue.guard(() async {
      recipe = await _recipeDataSource.getRecipe(id);
      return _cache..[id] = recipe;
    });

    return recipe;
  }

  @override
  Future<IndexedRecipe> updateRecipe(IndexedRecipe recipe) async {
    state = const AsyncValue.loading();

    late final IndexedRecipe updatedRecipe;
    state = await AsyncValue.guard(() async {
      updatedRecipe = await _recipeDataSource.updateRecipe(recipe);
      return _cache..[updatedRecipe.id] = updatedRecipe;
    });

    return updatedRecipe;
  }
}
