import 'package:domain/model/model.dart';

extension IngredientCopier on Ingredient {
  StoredIngredient withId(int id) => StoredIngredient(
        id: id,
        name: name,
        description: description,
      );
}
