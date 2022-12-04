part of 'local_source.dart';

class RecipeIsar implements RecipeSource {
  final _openIsar = Isar.open([
    IngredientSchema,
    RecipeSchema,
  ]);

  Future<int> addRecipe(Recipe recipe) => _upsertRecipe(recipe);

  Future<Recipe?> getRecipe(Id id) async {
    final isar = await _openIsar;
    return isar.recipes.getSync(id);
  }

  Future<int> updateRecipe(Recipe recipe) => _upsertRecipe(recipe);

  Future<bool> deleteRecipe(Id id) async {
    final isar = await _openIsar;
    return isar.recipes.deleteSync(id);
  }

  Future<int> addIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

  Future<Ingredient?> getIngredient(Id id) async {
    final isar = await _openIsar;
    return isar.ingredients.getSync(id);
  }

  Future<int> updateIngredient(Ingredient ingredient) =>
      _upsertIngredient(ingredient);

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
