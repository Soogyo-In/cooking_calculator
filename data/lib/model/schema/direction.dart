import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'schema.dart';

part 'direction.g.dart';

@Embedded(inheritance: false)
class Direction extends Equatable {
  const Direction({
    this.description = '',
    this.preps = const [],
    this.timeInSeconds = 0,
    this.temperature,
  });

  final String description;

  final List<Prep> preps;

  final int timeInSeconds;

  final Temperature? temperature;

  @ignore
  @override
  List<Object?> get props => [
        description,
        preps,
        timeInSeconds,
        temperature,
      ];
}
