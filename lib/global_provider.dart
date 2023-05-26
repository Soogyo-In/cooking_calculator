import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final recipeDatasourceProvider = FutureProvider<RecipeDatasource>(
  (ref) async {
    final directory = await getApplicationDocumentsDirectory();
    return RecipeLocalDatasource(directory.path);
  },
);
