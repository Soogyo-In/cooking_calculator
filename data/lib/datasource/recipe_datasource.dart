import 'package:domain/domain.dart';

abstract class RecipeDatasource {
  Future<IndexedRecipe> addRecipe(Recipe recipe);

  Future<IndexedRecipe> getRecipe(int id);

  Future<List<IndexedRecipe>> getAllRecipes();

  Future<IndexedRecipe> updateRecipe(IndexedRecipe recipe);

  Future<void> deleteRecipe(int id);

  Future<IndexedIngredient> addIngredient(Ingredient ingredient);

  Future<IndexedIngredient> getIngredient(int id);

  Future<List<IndexedIngredient>> getAllIngredients();

  Future<IndexedIngredient> updateIngredient(IndexedIngredient ingredient);

  Future<void> deleteIngredient(int id);
}
