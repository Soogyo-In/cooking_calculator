import 'package:domain/model/model.dart';

extension RecipeCopier on Recipe {
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
