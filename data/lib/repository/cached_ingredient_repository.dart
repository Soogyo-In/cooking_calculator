part of 'repository.dart';

typedef IngredientTable = Map<int, IndexedIngredient>;

class CachedIngredientRepository extends StateNotifier<IngredientTable>
    implements IngredientRepository {
  final RecipeDatasource _recipeDataSource;

  CachedIngredientRepository({
    required RecipeDatasource recipeDatasource,
    IngredientTable initialCache = const {},
  })  : _recipeDataSource = recipeDatasource,
        super(initialCache);

  @override
  Future<IndexedIngredient> addIngredient(Ingredient ingredient) async {
    final indexedIngredient = await _recipeDataSource.addIngredient(ingredient);

    state = Map.from(state)..[indexedIngredient.id] = indexedIngredient;

    return indexedIngredient;
  }

  @override
  Future<void> deleteIngredient(int id) async {
    await _recipeDataSource.deleteIngredient(id);

    state = Map.from(state)..remove(id);
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

    state = Map.from(state)..putIfAbsent(id, () => ingredient);

    return ingredient;
  }

  @override
  Future<IndexedIngredient> updateIngredient(
    IndexedIngredient ingredient,
  ) async {
    final updatedIngredient = await _recipeDataSource.updateIngredient(
      ingredient,
    );

    state = Map.from(state)..[updatedIngredient.id] = updatedIngredient;

    return updatedIngredient;
  }
}
