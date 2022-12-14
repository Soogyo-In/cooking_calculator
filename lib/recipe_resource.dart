import 'package:domain/domain.dart';

final ingredientById = {
  1: const Ingredient(name: 'pork belly'),
  2: const Ingredient(name: 'see salt'),
  3: const Ingredient(name: 'black pepper'),
  4: const Ingredient(
    name: 'cardamom pods',
    description: 'Bashed',
  ),
  5: const Ingredient(name: 'tbsp fennel seeds'),
  6: const Ingredient(
    name: 'fennel bulb',
    description: 'Trimmed and roughly sliced',
  ),
  7: const Ingredient(name: 'fresh bay leaves'),
  8: const Ingredient(
    name: 'garlic cloves',
    description: 'Peeled and bashed',
  ),
  9: const Ingredient(name: 'star anise'),
  10: const Ingredient(name: 'olive oil'),
  11: const Ingredient(name: 'white wine'),
  12: const Ingredient(
    name: 'chicken stock',
    description: 'depending on the size of your pan',
  ),
  13: const Ingredient(name: 'wholegrain mustard'),
};
const slowRoasetedPorkBellyRecipe = Recipe(
  name: 'SLOW ROASTED PORK BELLY',
  description:
      'Slow-roasting really locks in the flavours, and the end result will be a delicious crispy delight perfect to share with family and friends.',
  servings: 4,
  directions: [
    Direction(
      description: 'Preheat the oven to 180°C/Gas 4.',
      temperature: Temperature.celsius(180.0),
    ),
    Direction(
      description:
          'Score the pork belly skin diagonally in a diamond pattern at 1½ cm intervals. Season generously with salt and pepper, rubbing it well into the skin.',
      massByIngredientId: {
        1: Mass.kilogram(1.0),
      },
      countByIngredientId: {
        2: Count(0.0),
        3: Count(0.0),
      },
    ),
    Direction(
      description:
          'Put the fennel, bay leaves, garlic, cardamom, star anise and half the fennel seeds into a hot roasting tray on the hob with a little oil and heat for about 2 minutes until aromatic.',
      volumeByIngredientId: {
        4: Volume.teaspoon(1.0),
        5: Volume.tablespoon(0.5),
      },
      countByIngredientId: {
        6: Count(1.0),
        7: Count(4.0),
        8: Count(3.0),
        9: Count(4.0),
        10: Count(0.0),
      },
      time: Duration(minutes: 2),
    ),
    Direction(
      description:
          'Push to the side of the tray, then add the pork, skin side down, and cook for at least 5 minutes until turning golden brown.',
      massByIngredientId: {
        1: Mass.kilogram(1.0),
      },
      time: Duration(minutes: 5),
    ),
    Direction(
      description:
          'Turn the pork over, season the skin again with salt and sprinkle with the remaining fennel seeds. Pour in the wine to deglaze the pan, scraping up the bits from the bottom (be careful not to get the skin of the pork wet).',
      volumeByIngredientId: {
        5: Volume.tablespoon(0.5),
        11: Volume.milliliter(325.0),
      },
    ),
    Direction(
      description:
          'Bring to the boil, then pour in enough stock to come up to the layer of fat just below the skin and allow to boil again.',
      volumeByIngredientId: {
        12: Volume.milliliter(750.0),
      },
    ),
    Direction(
      description:
          'Transfer the tray to the preheated oven and cook for 2½ hours.',
      time: Duration(hours: 2, minutes: 30),
    ),
    Direction(
      description:
          'Transfer the meat to a warm plate and set aside to rest. Meanwhile, spoon off any excess fat in the roasting tray or drag a slice of bread along the surface of the cooking juices to absorb it. Heat the tray on the hob, adding the mustard. Mix in with a whisk, then taste and adjust the flavours as necessary. Remove the star anise and cardamom pods and pour the sauce into a jug. Serve the rested pork with the sauce alongside.',
      volumeByIngredientId: {
        13: Volume.tablespoon(1.0),
      },
    ),
  ],
);
