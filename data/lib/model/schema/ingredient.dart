import 'package:isar/isar.dart';

part 'ingredient.g.dart';

@collection
class Ingredient {
  final Id id;
  late String name;
  String? description;

  Ingredient({Id? id}) : id = id ?? Isar.autoIncrement;
}
