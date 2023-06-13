import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'enum/enum.dart';

part 'prep.g.dart';

@Embedded(inheritance: false)
class Prep extends Equatable {
  const Prep({
    this.ingredientId = -1,
    this.unit = MatterUnit.count,
    this.value = 0.0,
  });

  final int ingredientId;

  @enumerated
  final MatterUnit unit;

  final float value;

  @ignore
  @override
  List<Object?> get props => [
        ingredientId,
        unit,
        value,
      ];
}
