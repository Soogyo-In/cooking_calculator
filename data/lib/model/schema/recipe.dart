import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:ktc_dart/ktc_dart.dart';

import 'schema.dart';

part 'recipe.g.dart';

@Collection(inheritance: false)
class Recipe extends Equatable {
  const Recipe({
    this.id = Isar.autoIncrement,
    required this.name,
    this.directions = const [],
    this.servingUnit = ServingUnit.portion,
    this.servings = 1,
    this.description = '',
  });

  final Id id;

  @Index(unique: true, caseSensitive: false)
  final String name;

  final List<Direction> directions;

  @enumerated
  final ServingUnit servingUnit;

  final byte servings;

  final String description;

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get nameWords => name.split(' ');

  int get cookingTimeInSeconds =>
      directions.map((direction) => direction.cookingTimeInSeconds).fold(
            0,
            (total, cookingTimeInSeconds) => total + cookingTimeInSeconds,
          );

  List<int> get ingredientIds => directions
      .expand((direction) => direction.preps)
      .map((prep) => prep.ingredientId)
      .fold(
        <int>[],
        (total, ingredientId) => total..add(ingredientId),
      )
      .distinct
      .toList();

  @ignore
  @override
  List<Object?> get props => [
        id,
        name,
        directions,
        servingUnit,
        servings,
        description,
      ];
}

extension RecipeExtension on Recipe {
  List<Prep> get preps =>
      directions.expand((direction) => direction.preps).toList();
}
