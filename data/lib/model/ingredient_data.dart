import 'package:isar/isar.dart';

part 'ingredient_data.g.dart';

@collection
class IngredientData {
  final Id id;
  late String name;
  String? description;

  IngredientData({this.id = Isar.autoIncrement});
}
