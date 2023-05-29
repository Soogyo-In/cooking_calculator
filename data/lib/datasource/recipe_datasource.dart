import 'package:domain/domain.dart';

abstract class RecipeDatasource {
  Future<void> addRecipe(Recipe recipe);

  Future<Recipe> getRecipe(int id);

  Future<List<Recipe>> getAllRecipes();

  Future<void> updateRecipe({
    required int id,
    required Recipe recipe,
  });

  Future<void> deleteRecipe(int id);

  Future<void> addIngredient(Ingredient ingredient);

  Future<Ingredient> getIngredient(int id);

  Future<List<Ingredient>> getAllIngredients();

  Future<void> updateIngredient({
    required int id,
    required Ingredient ingredient,
  });

  Future<void> deleteIngredient(int id);
}
