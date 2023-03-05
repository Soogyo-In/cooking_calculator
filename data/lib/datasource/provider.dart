import 'package:data/data.dart';
import 'package:riverpod/riverpod.dart';

final recipeDatasourceProvider = Provider<RecipeDatasource>(
  (ref) => RecipeLocalDatasource(),
);
