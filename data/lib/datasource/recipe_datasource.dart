import 'package:domain/domain.dart';

abstract class RecipeDatasource {
  Future<Recipe> addRecipe(Recipe recipe);

  Future<Recipe> getRecipe(int id);

  Future<void> updateRecipe(Recipe recipe);

  Future<void> deleteRecipe(int id);

  Future<Ingredient> addIngredient(Ingredient ingredient);

  Future<Ingredient> getIngredient(int id);

  Future<void> updateIngredient(Ingredient ingredient);

  Future<void> deleteIngredient(int id);
}
