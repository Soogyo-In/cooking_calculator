import 'package:isar/isar.dart';

part 'ingredient.g.dart';

@collection
class Ingredient {
  Ingredient({this.id = Isar.autoIncrement});

  final Id id;

  @Index(unique: true, caseSensitive: false)
  late String name;

  String? description;
}
