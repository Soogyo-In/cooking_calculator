part of 'repository.dart';

class CachedIngredientRepository
    extends StateNotifier<Map<int, IndexedIngredient>>
    implements IngredientRepository {
  final RecipeDatasource _recipeDataSource;

  CachedIngredientRepository(RecipeDatasource recipeDataSource)
      : _recipeDataSource = recipeDataSource,
        super({});

  @override
  Future<IndexedIngredient> addIngredient(Ingredient ingredient) async {
    final indexedIngredient = await _recipeDataSource.addIngredient(ingredient);
    state[indexedIngredient.id] = indexedIngredient;

    return indexedIngredient;
  }

  @override
  Future<void> deleteIngredient(int id) async {
    await _recipeDataSource.deleteIngredient(id);
    state.remove(id);
  }

  @override
  Future<List<IndexedIngredient>> getAllIngredients() async {
    if (state.isNotEmpty) return state.values.toList();

    final ingredients = await _recipeDataSource.getAllIngredients();
    state = {for (final ingredient in ingredients) ingredient.id: ingredient};

    return ingredients;
  }

  @override
  Future<IndexedIngredient> getIngredient(int id) async {
    final ingredient = state[id] ?? await _recipeDataSource.getIngredient(id);

    state.putIfAbsent(id, () => ingredient);

    return ingredient;
  }

  @override
  Future<IndexedIngredient> updateIngredient(
    IndexedIngredient ingredient,
  ) async {
    final updatedIngredient = await _recipeDataSource.updateIngredient(
      ingredient,
    );
    state[updatedIngredient.id] = updatedIngredient;

    return updatedIngredient;
  }
}
