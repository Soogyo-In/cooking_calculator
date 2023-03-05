import 'package:data/data.dart';
import 'package:riverpod/riverpod.dart';

final cachedRecipeRepositoryProvider =
    AsyncNotifierProvider<CachedRecipeRepository, RecipeTable>(
  () => CachedRecipeRepository(),
);

final cachedIngredientRepositoryProvider =
    AsyncNotifierProvider<CachedIngredientRepository, IngredientTable>(
  () => CachedIngredientRepository(),
);
