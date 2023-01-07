import 'package:data/data.dart';
import 'package:domain/model/ingredient.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test(
    'IngredientData can covner to IndexedIngredient',
    () {
      final ingredientData = IngredientData(id: 1)
        ..name = 'name'
        ..description = 'description';

      expect(
        ingredientData.toIngredient(),
        IndexedIngredient(
          id: 1,
          name: 'name',
          description: 'description',
        ),
      );
    },
  );
}
