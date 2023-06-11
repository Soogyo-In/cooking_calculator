import 'package:domain/domain.dart';

abstract class RecipeDatasource {
  Future<int> addRecipe(Recipe recipe);

  Future<StoredRecipe> getRecipe(int id);

  Future<List<StoredRecipe>> getAllRecipes();

  Future<void> updateRecipe({
    required int id,
    required Recipe recipe,
  });

  Future<void> deleteRecipe(int id);

  Future<int> addIngredient(Ingredient ingredient);

  Future<StoredIngredient> getIngredient(int id);

  Future<List<StoredIngredient>> getAllIngredients();

  Future<void> updateIngredient({
    required int id,
    required Ingredient ingredient,
  });

  Future<void> deleteIngredient(int id);
}
