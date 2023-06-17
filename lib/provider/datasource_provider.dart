part of 'provider.dart';

final recipeLocalDatasourceProvider = FutureProvider<RecipeDatasource>(
  (ref) async {
    final directory = await getApplicationDocumentsDirectory();
    return RecipeLocalDatasource(directory.path);
  },
);
