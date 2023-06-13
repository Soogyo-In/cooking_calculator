import 'package:domain/domain.dart';

abstract class RecipeDatasource {
  Future<StoredRecipe> addRecipe(Recipe recipe);

  Future<StoredRecipe> getRecipe(int id);

  Future<List<StoredRecipe>> getAllRecipes();

  Future<StoredRecipe> updateRecipe({
    required int id,
    required Recipe recipe,
  });

  Future<void> deleteRecipe(int id);

  Future<StoredIngredient> addIngredient(Ingredient ingredient);

  Future<StoredIngredient> getIngredient(int id);

  Future<List<StoredIngredient>> getAllIngredients();

  Future<StoredIngredient> updateIngredient({
    required int id,
    required Ingredient ingredient,
  });

  Future<void> deleteIngredient(int id);
}
