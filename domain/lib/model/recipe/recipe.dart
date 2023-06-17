import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'direction.dart';
part 'ingredient.dart';
part 'prep.dart';

class Recipe extends Equatable {
  const Recipe({
    this.name = '',
    this.directions = const [],
    this.servings = 1,
    this.description = '',
  });

  final String name;

  final List<Direction> directions;

  final int servings;

  final String description;

  @override
  List<Object?> get props => [
        name,
        directions,
        servings,
        description,
      ];

  Duration get time => directions.fold(
        const Duration(),
        (time, direction) => time + direction.time,
      );

  Recipe copyWith({
    String? name,
    List<Direction>? directions,
    int? servings,
    String? description,
  }) =>
      Recipe(
        name: name ?? this.name,
        directions: directions ?? this.directions,
        servings: servings ?? this.servings,
        description: description ?? this.description,
      );

  StoredRecipe withId(int id) => StoredRecipe(
        id: id,
        name: name,
        directions: directions,
        description: description,
        servings: servings,
      );
}

class StoredRecipe extends Recipe {
  const StoredRecipe({
    required this.id,
    required super.name,
    required super.directions,
    super.servings = 1,
    super.description = '',
  });

  final int id;

  @override
  List<Object?> get props => super.props..add(id);
}
