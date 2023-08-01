import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeListProvider = FutureProvider(
  (ref) => ref
      .watch(recipeLocalDatasourceProvider.future)
      .then((datasource) => datasource.getAllRecipes()),
);

final recipeProvider = StateProvider<Recipe>((ref) => const Recipe());
