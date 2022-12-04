part of 'local_source.dart';

class RecipeIsar implements domain.RecipeSource {
  final _openIsar = Isar.open([
    IngredientSchema,
    RecipeSchema,
  ]);

  @override
  Future<int> addRecipe(domain.Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<domain.Recipe?> getRecipe(Id id) async {
    final isar = await _openIsar;
    return isar.recipes.getSync(id);
  }

  @override
  Future<int> updateRecipe(domain.Recipe recipe) => _upsertRecipe(recipe);

  @override
  Future<bool> deleteRecipe(Id id) async {
    final isar = await _openIsar;
    return isar.recipes.deleteSync(id);
  }

  @override
  Future<int> addIngredient(domain.Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<domain.Ingredient?> getIngredient(Id id) async {
    final isar = await _openIsar;
    return isar.ingredients.getSync(id);
  }

  @override
  Future<int> updateIngredient(domain.Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  @override
  Future<bool> deleteIngredient(Id id) async {
    final isar = await _openIsar;
    return isar.ingredients.deleteSync(id);
  }

  Future<int> _upsertRecipe(Recipe recipe) async {
    final isar = await _openIsar;
    return isar.recipes.putSync(recipe);
  }

  Future<int> _upsertIngredient(Ingredient ingredient) async {
    final isar = await _openIsar;
    return isar.ingredients.putSync(ingredient);
  }
}
