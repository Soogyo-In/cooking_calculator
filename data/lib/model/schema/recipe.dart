import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'schema.dart';

part 'recipe.g.dart';

@Collection(inheritance: false)
class Recipe extends Equatable {
  const Recipe({
    this.id = Isar.autoIncrement,
    required this.name,
    this.directions = const [],
    this.servings = 1,
    this.description = '',
  });

  final Id id;

  final String name;

  final List<Direction> directions;

  final byte servings;

  final String description;

  @ignore
  @override
  List<Object?> get props => [
        id,
        name,
        directions,
        servings,
        description,
      ];
}

extension RecipeExtension on Recipe {
  List<Prep> get preps =>
      directions.expand((direction) => direction.preps).toList();
}
