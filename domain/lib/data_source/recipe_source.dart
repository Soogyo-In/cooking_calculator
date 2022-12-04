import 'package:domain/domain.dart';

abstract class RecipeSource {
  Future<int> addRecipe(Recipe recipe);

  Future<Recipe?> getRecipe(int id);

  Future<int> updateRecipe(Recipe recipe);

  Future<bool> deleteRecipe(int id);

  Future<int> addIngredient(Ingredient ingredient);

  Future<Ingredient?> getIngredient(int id);

  Future<int> updateIngredient(Ingredient ingredient);

  Future<bool> deleteIngredient(int id);
}
