import 'package:cooking_calulator/model/model.dart';
import 'package:flutter/material.dart';

final _recipe = Recipe(
  name: 'SLOW ROASTED PORK BELLY',
  description:
      'Slow-roasting really locks in the flavours, and the end result will be a delicious crispy delight perfect to share with family and friends.',
  servings: 4,
  directions: [
    const Direction(
      description: 'Preheat the oven to 180°C/Gas 4.',
      temperature: Temperature.celsius(180.0),
    ),
    Direction(
      description:
          'Score the pork belly skin diagonally in a diamond pattern at 1½ cm intervals. Season generously with salt and pepper, rubbing it well into the skin.',
      massByIngredient: {
        const Ingredient(name: 'pork belly'): const Mass.kilogram(1.0),
      },
      countByIngredient: {
        const Ingredient(name: 'see salt'): const Count(0.0),
        const Ingredient(name: 'black pepper'): const Count(0.0),
      },
    ),
    Direction(
      description:
          'Put the fennel, bay leaves, garlic, cardamom, star anise and half the fennel seeds into a hot roasting tray on the hob with a little oil and heat for about 2 minutes until aromatic.',
      volumeByIngredient: {
        const Ingredient(
          name: 'cardamom pods',
          description: 'Bashed',
        ): const Volume.teaspoon(1.0),
        const Ingredient(name: 'tbsp fennel seeds'):
            const Volume.tablespoon(0.5),
      },
      countByIngredient: {
        const Ingredient(
          name: 'fennel bulb',
          description: 'Trimmed and roughly sliced',
        ): const Count(1.0),
        const Ingredient(name: 'fresh bay leaves'): const Count(4.0),
        const Ingredient(
          name: 'garlic cloves',
          description: 'Peeled and bashed',
        ): const Count(3.0),
        const Ingredient(name: 'star anise'): const Count(4.0),
        const Ingredient(name: 'olive oil'): const Count(0.0),
      },
      time: const Duration(minutes: 2),
    ),
    Direction(
      description:
          'Push to the side of the tray, then add the pork, skin side down, and cook for at least 5 minutes until turning golden brown.',
      massByIngredient: {
        const Ingredient(name: 'pork belly'): const Mass.kilogram(1.0),
      },
      time: const Duration(minutes: 5),
    ),
    Direction(
      description:
          'Turn the pork over, season the skin again with salt and sprinkle with the remaining fennel seeds. Pour in the wine to deglaze the pan, scraping up the bits from the bottom (be careful not to get the skin of the pork wet).',
      volumeByIngredient: {
        const Ingredient(name: 'tbsp fennel seeds'):
            const Volume.tablespoon(0.5),
        const Ingredient(name: 'white wine'): const Volume.milliliter(325.0),
      },
    ),
    Direction(
      description:
          'Bring to the boil, then pour in enough stock to come up to the layer of fat just below the skin and allow to boil again.',
      volumeByIngredient: {
        const Ingredient(
          name: 'chicken stock',
          description: 'depending on the size of your pan',
        ): const Volume.milliliter(750.0),
      },
    ),
    const Direction(
      description:
          'Transfer the tray to the preheated oven and cook for 2½ hours.',
      time: Duration(hours: 2, minutes: 30),
    ),
    Direction(
      description:
          'Transfer the meat to a warm plate and set aside to rest. Meanwhile, spoon off any excess fat in the roasting tray or drag a slice of bread along the surface of the cooking juices to absorb it. Heat the tray on the hob, adding the mustard. Mix in with a whisk, then taste and adjust the flavours as necessary. Remove the star anise and cardamom pods and pour the sauce into a jug. Serve the rested pork with the sauce alongside.',
      volumeByIngredient: {
        const Ingredient(name: 'wholegrain mustard'):
            const Volume.tablespoon(1.0),
      },
    ),
  ],
);

class RecipeEditPage extends StatelessWidget {
  const RecipeEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe editor')),
      body: Column(
        children: [],
      ),
    );
  }
}
