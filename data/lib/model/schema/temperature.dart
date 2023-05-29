import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'temperature.g.dart';

@embedded
class Temperature {
  @enumerated
  late TemperatureUnit unit;

  late float value;
}
