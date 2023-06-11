import 'package:data/data.dart';
import 'package:domain/domain.dart' as domain;
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
        domain.Ingredient(
          name: 'name',
          description: 'description',
        ),
      );
    },
  );

  test(
    'Data ingredient should convert to stored ingredient',
    () {
      final ingredient = Ingredient(
        id: 1,
        name: 'name',
        description: 'description',
      );

      expect(
        ingredient.toStoredModel(ingredient.id),
        domain.StoredIngredient(
          id: ingredient.id,
          name: 'name',
          description: 'description',
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
      final dataIgredient = ingredient.toDataModel(id: 0);

      expect(dataIgredient.id, 0);
      expect(dataIgredient.name, ingredient.name);
      expect(dataIgredient.description, ingredient.description);
    },
  );
}
