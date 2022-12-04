import 'package:isar/isar.dart';

part 'ingredient.g.dart';

@collection
class Ingredient {
  final id = Isar.autoIncrement;
  late String name;
  String? description;
}
