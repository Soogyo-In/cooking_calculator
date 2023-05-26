import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add.dart';

final recipeProvider = StateProvider(
  (ref) => const Recipe(name: '', directions: []),
);

class RecipeAddScope extends StatelessWidget {
  const RecipeAddScope({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        recipeProvider.overrideWith(
          (ref) => const Recipe(name: '', directions: []),
        ),
      ],
      child: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AddDirectionPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const AddDirectionPage(),
                settings: settings,
              );
            case AddIngredientPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const AddIngredientPage(),
                settings: settings,
              );
            case AddTitlePage.routeName:
              return MaterialPageRoute(
                builder: (context) => const AddTitlePage(),
                settings: settings,
              );
          }
        },
      ),
    );
  }
}
