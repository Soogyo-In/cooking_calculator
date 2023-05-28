part of 'repository.dart';

abstract class RecipeRepository {
  Future<Recipe> addRecipe(Recipe recipe);

  Future<Recipe> getRecipe(int id);

  Future<List<Recipe>> getAllRecipes();

  Future<Recipe> updateRecipe({
    required int id,
    required Recipe recipe,
  });

  Future<void> deleteRecipe(int id);
}
