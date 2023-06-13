part of 'repository.dart';

abstract class IngredientRepository {
  Future<Ingredient> addIngredient(Ingredient ingredient);

  Future<Ingredient> getIngredient(int id);

  Future<List<Ingredient>> getAllIngredients();

  Future<Ingredient> updateIngredient({
    required int id,
    required Ingredient ingredient,
  });

  Future<void> deleteIngredient(int id);
}
