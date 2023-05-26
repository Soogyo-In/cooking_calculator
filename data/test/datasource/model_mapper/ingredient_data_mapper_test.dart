import 'package:data/data.dart';
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
        Ingredient(
          id: 1,
          name: 'name',
          description: 'description',
        ),
      );
    },
  );
}
