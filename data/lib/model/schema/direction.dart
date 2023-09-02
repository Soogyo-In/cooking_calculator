import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'schema.dart';

part 'direction.g.dart';

@Embedded(inheritance: false)
class Direction extends Equatable {
  const Direction({
    this.description = '',
    this.preps = const [],
    this.cookingTimeInSeconds = 0,
    this.cookingTemperature,
  });

  final String description;

  final List<Prep> preps;

  final int cookingTimeInSeconds;

  final Temperature? cookingTemperature;

  @ignore
  @override
  List<Object?> get props => [
        description,
        preps,
        cookingTimeInSeconds,
        cookingTemperature,
      ];
}
