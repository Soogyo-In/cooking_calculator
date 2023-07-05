import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'ingredient.g.dart';

@Collection(inheritance: false)
class Ingredient extends Equatable {
  const Ingredient({
    this.id = Isar.autoIncrement,
    required this.name,
    this.description = '',
  });

  final Id id;

  @Index(unique: true, caseSensitive: false)
  final String name;

  final String description;

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get nameWords => name.split(' ');

  @ignore
  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];
}
