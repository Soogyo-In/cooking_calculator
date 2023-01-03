import 'package:data/data.dart';
import 'package:riverpod/riverpod.dart';

final cachedRecipeRepositoryProvider = StateNotifierProvider(
  (ref) => CachedRecipeRepository(RecipeLocalDatasource()),
);

final cachedIngredientRepositoryProvider = StateNotifierProvider(
  (ref) => CachedIngredientRepository(RecipeLocalDatasource()),
);
