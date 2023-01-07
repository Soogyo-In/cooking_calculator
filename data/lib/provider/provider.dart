import 'package:data/data.dart';
import 'package:riverpod/riverpod.dart';

final cachedRecipeRepositoryProvider = StateNotifierProvider.family<
    CachedRecipeRepository, RecipeTable, RecipeDatasource>(
  (ref, recipeDatasource) => CachedRecipeRepository(
    recipeDatasource: recipeDatasource,
  ),
);

final cachedIngredientRepositoryProvider = StateNotifierProvider.family<
    CachedIngredientRepository, IngredientTable, RecipeDatasource>(
  (ref, recipeDatasource) => CachedIngredientRepository(
    recipeDatasource: recipeDatasource,
  ),
);
