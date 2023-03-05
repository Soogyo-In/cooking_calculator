part of 'repository.dart';

typedef IngredientTable = Map<int, IndexedIngredient>;

class CachedIngredientRepository extends AsyncNotifier<IngredientTable>
    implements IngredientRepository {
  final _cache = <int, IndexedIngredient>{};

  RecipeDatasource get _recipeDataSource => ref.watch(recipeDatasourceProvider);

  @override
  FutureOr<IngredientTable> build() async {
    final ingredients = await _recipeDataSource.getAllIngredients();
    for (final ingredient in ingredients) {
      _cache[ingredient.id] = ingredient;
    }
    return _cache;
  }

  @override
  Future<IndexedIngredient> addIngredient(Ingredient ingredient) async {
    state = const AsyncValue.loading();

    late final IndexedIngredient indexedIngredient;
    state = await AsyncValue.guard(() async {
      indexedIngredient = await _recipeDataSource.addIngredient(ingredient);
      return _cache..[indexedIngredient.id] = indexedIngredient;
    });

    return indexedIngredient;
  }

  @override
  Future<void> deleteIngredient(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _recipeDataSource.deleteIngredient(id);
      return _cache..remove(id);
    });
  }

  @override
  Future<List<IndexedIngredient>> getAllIngredients() async {
    if (_cache.isNotEmpty) return Future.sync(() => _cache.values.toList());

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final ingredients = await _recipeDataSource.getAllIngredients();
      for (final ingredient in ingredients) {
        _cache[ingredient.id] = ingredient;
      }
      return _cache;
    });

    return _cache.values.toList();
  }

  @override
  Future<IndexedIngredient> getIngredient(int id) async {
    final cache = _cache[id];
    if (cache != null) return Future.sync(() => cache);

    state = const AsyncValue.loading();

    late final IndexedIngredient ingredient;
    state = await AsyncValue.guard(() async {
      ingredient = await _recipeDataSource.getIngredient(id);
      return _cache..[id] = ingredient;
    });

    return ingredient;
  }

  @override
  Future<IndexedIngredient> updateIngredient(
    IndexedIngredient ingredient,
  ) async {
    state = const AsyncValue.loading();

    late final IndexedIngredient updatedIngredient;
    state = await AsyncValue.guard(() async {
      updatedIngredient = await _recipeDataSource.updateIngredient(ingredient);
      return _cache..[updatedIngredient.id] = updatedIngredient;
    });

    return updatedIngredient;
  }
}
