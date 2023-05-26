import 'package:cooking_calulator/global_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipesProvider = FutureProvider(
  (ref) async {
    final datasource = await ref.read(recipeDatasourceProvider.future);
    final recipes = await datasource.getAllRecipes();
    final ingredients = await datasource.getAllIngredients();
    final ingredientById = {
      for (final ingredient in ingredients) ingredient.id: ingredient
    };
  },
);

final ingredientsProvider = FutureProvider((ref) => ref
    .read(recipeDatasourceProvider.future)
    .then((provider) => provider.getAllIngredients()));
