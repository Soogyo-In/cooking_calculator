import 'package:data/data.dart';
import 'package:isar/isar.dart';

class ErrorRecipeLocalDatasource extends RecipeLocalDatasource {
  ErrorRecipeLocalDatasource(super.databasePath);

  @override
  Future<List<StoredIngredient>> searchIngredients({String? name}) {
    throw Exception();
  }

  @override
  Future<StoredRecipe> addRecipe(Recipe recipe) {
    throw Exception();
  }

  @override
  Future<StoredRecipe> updateRecipe({required Id id, required Recipe recipe}) {
    throw Exception();
  }

  @override
  Future<void> deleteRecipe(Id id) {
    throw Exception();
  }
}
