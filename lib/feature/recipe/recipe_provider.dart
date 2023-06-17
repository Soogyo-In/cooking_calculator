import 'package:cooking_calulator/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeListProvider = FutureProvider(
  (ref) async {
    final datasource = await ref.watch(recipeLocalDatasourceProvider.future);
    return datasource.getAllRecipes();
  },
);
