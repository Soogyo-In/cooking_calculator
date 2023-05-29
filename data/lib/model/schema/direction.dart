import 'package:isar/isar.dart';

import 'schema.dart';

part 'direction.g.dart';

@embedded
class Direction {
  late String description;

  List<Prep>? preps;

  int? timeInSeconds;

  Temperature? temperature;
}
