import 'package:data/data.dart';
import 'package:isar/isar.dart';

class ErrorRecipeLocalDatasource extends RecipeLocalDatasource {
  ErrorRecipeLocalDatasource() : super('./');

  @override
  Future<List<StoredIngredient>> searchIngredients({String? name}) {
    throw Exception();
  }

  @override
  Future<List<StoredRecipe>> searchRecipes({
    int page = 0,
    int size = 0,
    String name = '',
    List<Id> ingredientIds = const [],
    Duration? cookingTime,
  }) {
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
