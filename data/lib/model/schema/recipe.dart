import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  final id = Isar.autoIncrement;
  late String name;
  late List<Direction> directions;
  late byte servings;
  String? description;
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
  late int id;
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
