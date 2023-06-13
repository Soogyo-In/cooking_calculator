part of 'recipe.dart';

class Direction extends Equatable {
  const Direction({
    required this.description,
    this.preps = const [],
    this.time = const Duration(),
    this.temperature,
  });

  final String description;

  final List<Prep> preps;

  final Duration time;

  final Temperature? temperature;

  @override
  List<Object?> get props => [
        description,
        preps,
        time,
        temperature,
      ];
}
