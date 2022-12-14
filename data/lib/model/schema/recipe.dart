import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  final Id id;
  late String name;
  late List<Direction> directions;
  late byte servings;
  String? description;

  Recipe({Id? id}) : id = id ?? Isar.autoIncrement;
}

@embedded
class Direction {
  late String description;
  List<IngredientAmount>? ingredients;
  int? timeInSeconds;
  Temperature? temperature;
}

@embedded
class IngredientAmount {
  late int ingredientId;
  @enumerated
  late MatterUnit unit;
  late float value;
}

@embedded
class Temperature {
  @enumerated
  late TemperatureUnit unit;
  late float value;
}
