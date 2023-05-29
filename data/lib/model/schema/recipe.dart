import 'package:isar/isar.dart';

import 'schema.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  Recipe({this.id = Isar.autoIncrement});

  final Id id;

  late String name;

  late List<Direction> directions;

  late byte servings;

  String? description;
}

extension RecipeExtension on Recipe {
  List<Prep> get preps =>
      directions.expand((direction) => direction.preps ?? <Prep>[]).toList();
}
