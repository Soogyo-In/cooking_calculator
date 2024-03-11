import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'direction.dart';
part 'enum/serving_unit.dart';
part 'ingredient.dart';
part 'prep.dart';

class Recipe extends Equatable {
  const Recipe({
    this.name = '',
    this.directions = const [],
    this.servingUnit = ServingUnit.portion,
    this.servings = 1,
    this.description = '',
  });

  final String name;

  final List<Direction> directions;

  final ServingUnit servingUnit;

  final int servings;

  final String description;

  @override
  List<Object?> get props => [
        name,
        directions,
        servingUnit,
        servings,
        description,
      ];

  Duration get time => directions.fold(
        const Duration(),
        (time, direction) => time + direction.cookingTime,
      );

  Recipe copyWith({
    String? name,
    List<Direction>? directions,
    ServingUnit? servingUnit,
    int? servings,
    String? description,
  }) =>
      Recipe(
        name: name ?? this.name,
        directions: directions ?? this.directions,
        servingUnit: servingUnit ?? this.servingUnit,
        servings: servings ?? this.servings,
        description: description ?? this.description,
      );

  StoredRecipe withId(int id) => StoredRecipe(
        id: id,
        name: name,
        description: description,
        servingUnit: servingUnit,
        servings: servings,
        directions: directions,
      );
}

class StoredRecipe extends Recipe {
  const StoredRecipe({
    required this.id,
    super.name,
    super.directions,
    super.servingUnit,
    super.servings,
    super.description,
  });

  final int id;

  @override
  List<Object?> get props => super.props..add(id);
}
