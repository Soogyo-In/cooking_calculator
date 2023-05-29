import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'prep.g.dart';

@embedded
class Prep {
  late int ingredientId;

  @enumerated
  late MatterUnit unit;

  late float value;
}
