part of 'recipe.dart';

class Ingredient extends Equatable {
  const Ingredient({
    required this.name,
    this.description = '',
  });

  final String name;

  final String description;

  @override
  List<Object?> get props => [name, description];
}
