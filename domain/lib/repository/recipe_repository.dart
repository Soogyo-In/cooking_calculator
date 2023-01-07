part of 'repository.dart';

abstract class RecipeRepository {
  Future<IndexedRecipe> addRecipe(Recipe recipe);

  Future<IndexedRecipe> getRecipe(int id);

  Future<List<IndexedRecipe>> getAllRecipes();

  Future<IndexedRecipe> updateRecipe(IndexedRecipe recipe);

  Future<void> deleteRecipe(int id);
}
