part of 'repository.dart';

abstract class IngredientRepository {
  Future<IndexedIngredient> addIngredient(Ingredient ingredient);

  Future<IndexedIngredient> getIngredient(int id);

  Future<List<IndexedIngredient>> getAllIngredients();

  Future<IndexedIngredient> updateIngredient(IndexedIngredient ingredient);

  Future<void> deleteIngredient(int id);
}
