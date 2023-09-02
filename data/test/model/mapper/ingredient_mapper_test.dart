import 'package:data/model/model.dart';
import 'package:domain/domain.dart' as domain;
import 'package:isar/isar.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Data ingredient should convert to domain ingredient',
    () {
      final ingredient = Ingredient(
        id: 1,
        name: 'name',
        description: 'description',
      );

      expect(
        ingredient.toDomainModel(),
        domain.StoredIngredient(
          id: ingredient.id,
          name: ingredient.name,
          description: ingredient.description,
        ),
      );
    },
  );

  test(
    'Domain ingredient should convert to data ingredient',
    () {
      final ingredient = domain.Ingredient(
        name: 'name',
        description: 'description',
      );

      expect(
        ingredient.toDataModel(),
        Ingredient(
          id: Isar.autoIncrement,
          name: ingredient.name,
          description: ingredient.description,
        ),
      );
    },
  );
}
