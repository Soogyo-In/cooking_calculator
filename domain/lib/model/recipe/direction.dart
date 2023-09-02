part of 'recipe.dart';

class Direction extends Equatable {
  const Direction({
    this.description = '',
    this.preps = const [],
    this.cookingTime = const Duration(),
    this.cookingTemperature,
  });

  final String description;

  final List<Prep> preps;

  final Duration cookingTime;

  final Temperature? cookingTemperature;

  @override
  List<Object?> get props => [
        description,
        preps,
        cookingTime,
        cookingTemperature,
      ];
}
