part of 'search_recipes_intent_test.dart';

final _recipeSchemas = [
  schema.Recipe(
    id: 1,
    name: 'recipe11',
    directions: [
      schema.Direction(
        preps: const [
          schema.Prep(ingredientId: 1),
        ],
        cookingTimeInSeconds: const Duration(hours: 3).inSeconds,
      ),
    ],
  ),
  schema.Recipe(
    id: 2,
    name: 'recipe12',
    directions: [
      schema.Direction(
        preps: const [
          schema.Prep(ingredientId: 1),
          schema.Prep(ingredientId: 2),
        ],
        cookingTimeInSeconds: const Duration(hours: 2).inSeconds,
      ),
    ],
  ),
  schema.Recipe(
    id: 3,
    name: 'recipe21',
    directions: [
      schema.Direction(
        preps: const [
          schema.Prep(ingredientId: 1),
          schema.Prep(ingredientId: 3),
        ],
        cookingTimeInSeconds: const Duration(hours: 1).inSeconds,
      ),
    ],
  ),
  const schema.Recipe(
    id: 4,
    name: 'recipe22',
    directions: [
      schema.Direction(
        preps: [
          schema.Prep(ingredientId: 2),
          schema.Prep(ingredientId: 3),
        ],
      ),
    ],
  ),
];

final _storedRecipes = _recipeSchemas
    .map((recipeSchema) => recipeSchema.toDomainModel(_ingredientSchemas))
    .toList();

const _ingredientSchemas = [
  schema.Ingredient(
    id: 1,
    name: 'carrot',
  ),
  schema.Ingredient(
    id: 2,
    name: 'onion',
  ),
  schema.Ingredient(
    id: 3,
    name: 'tomato',
  ),
];
