import 'package:data/data.dart';
import 'package:riverpod/riverpod.dart';

final cachedRecipeRepositoryProvider =
    StateNotifierProvider<CachedRecipeRepository, RecipeTable>(
  (ref) => CachedRecipeRepository(
    recipeDataSource: RecipeLocalDatasource(),
  ),
);

final cachedIngredientRepositoryProvider =
    StateNotifierProvider<CachedIngredientRepository, IngredientTable>(
  (ref) => CachedIngredientRepository(
    recipeDatasource: RecipeLocalDatasource(),
  ),
);
