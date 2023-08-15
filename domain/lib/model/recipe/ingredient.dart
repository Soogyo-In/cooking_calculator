part of 'recipe.dart';

class Ingredient extends Equatable {
  const Ingredient({
    this.name = '',
    this.description = '',
  });

  final String name;

  final String description;

  @override
  List<Object?> get props => [name, description];
}

class StoredIngredient extends Ingredient {
  const StoredIngredient({
    required this.id,
    super.name,
    super.description,
  });

  final int id;

  @override
  List<Object?> get props => super.props..add(id);
}
