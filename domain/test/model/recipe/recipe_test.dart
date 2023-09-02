import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  late Recipe recipe;

  setUp(() {
    recipe = Recipe(
      name: 'recipe',
      servings: 4,
      directions: [
        Direction(
          description: 'step 1',
          cookingTime: const Duration(minutes: 1),
        ),
        Direction(
          description: 'step 2',
          cookingTime: const Duration(days: 1),
        ),
        Direction(
          description: 'step 3',
          cookingTime: Duration(minutes: 25),
          cookingTemperature: Temperature.celsius(170.0),
        ),
      ],
    );
  });

  test(
    'Recipe provides cooking time',
    () {
      expect(
        recipe.time,
        const Duration(days: 1, minutes: 26),
      );
    },
  );
}
