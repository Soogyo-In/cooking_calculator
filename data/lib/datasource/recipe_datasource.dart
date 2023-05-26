import 'package:domain/domain.dart';

abstract class RecipeDatasource {
  Future<Recipe> addRecipe(TransientRecipe recipe);

  Future<Recipe> getRecipe(int id);

  Future<List<Recipe>> getAllRecipes();

  Future<Recipe> updateRecipe(Recipe recipe);

  Future<void> deleteRecipe(int id);

  Future<Ingredient> addIngredient(TransientIngredient ingredient);

  Future<Ingredient> getIngredient(int id);

  Future<List<Ingredient>> getAllIngredients();

  Future<Ingredient> updateIngredient(Ingredient ingredient);

  Future<void> deleteIngredient(int id);
}
