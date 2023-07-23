import 'package:data/data.dart';

class ErrorRecipeLocalDatasource extends RecipeLocalDatasource {
  ErrorRecipeLocalDatasource(super.databasePath);

  @override
  Future<List<StoredIngredient>> searchIngredients({String? name}) {
    throw Exception();
  }
}
