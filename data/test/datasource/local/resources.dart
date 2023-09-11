part of 'recipe_local_datasource_test.dart';

final _recipeSchemas = [
  Recipe(
    id: 1,
    name: 'recipe11',
    directions: [
      Direction(
        preps: [
          Prep(ingredientId: 1),
        ],
        cookingTimeInSeconds: Duration(hours: 3).inSeconds,
      ),
    ],
  ),
  Recipe(
    id: 2,
    name: 'recipe12',
    directions: [
      Direction(
        preps: [
          Prep(ingredientId: 1),
          Prep(ingredientId: 2),
        ],
        cookingTimeInSeconds: Duration(hours: 2).inSeconds,
      ),
    ],
  ),
  Recipe(
    id: 3,
    name: 'recipe21',
    directions: [
      Direction(
        preps: [
          Prep(ingredientId: 1),
          Prep(ingredientId: 3),
        ],
        cookingTimeInSeconds: Duration(hours: 1).inSeconds,
      ),
    ],
  ),
  Recipe(
    id: 4,
    name: 'recipe22',
    directions: [
      Direction(
        preps: [
          Prep(ingredientId: 2),
          Prep(ingredientId: 3),
        ],
      ),
    ],
  ),
];

final _storedRecipes = _recipeSchemas
    .map((recipeSchema) => recipeSchema.toDomainModel(_ingredientSchemas))
    .toList();

final _ingredientSchemas = [
  Ingredient(
    id: 1,
    name: 'carrot',
  ),
  Ingredient(
    id: 2,
    name: 'onion',
  ),
  Ingredient(
    id: 3,
    name: 'tomato',
  ),
];
