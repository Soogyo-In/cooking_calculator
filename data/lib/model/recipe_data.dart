import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'recipe_data.g.dart';

@collection
class RecipeData {
  final Id id;
  late String name;
  late List<DirectionData> directions;
  late byte servings;
  String? description;

  RecipeData({this.id = Isar.autoIncrement});

  Set<int> get ingredientIdSet => directions
      .expand((direction) => direction.preps ?? <PrepData>[])
      .map((prep) => prep.ingredientId)
      .toSet();
}

@embedded
class DirectionData {
  late String description;
  List<PrepData>? preps;
  int? timeInSeconds;
  TemperatureData? temperature;
}

@embedded
class PrepData {
  late int ingredientId;
  @enumerated
  late MatterUnit unit;
  late float value;
}

@embedded
class TemperatureData {
  @enumerated
  late TemperatureUnit unit;
  late float value;
}
