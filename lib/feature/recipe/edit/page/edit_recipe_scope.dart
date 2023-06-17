import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../edit.dart';
import '../provider.dart';

class EditRecipeScope extends StatelessWidget {
  const EditRecipeScope({
    super.key,
    this.id,
    this.recipe = const Recipe(),
  });

  final int? id;

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        recipeProvider.overrideWith((ref) => recipe),
      ],
      child: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case EditDirectionPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const EditDirectionPage(),
                settings: settings,
              );
            case EditIngredientPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const EditIngredientPage(),
                settings: settings,
              );
            case EditRecipePage.routeName:
              return MaterialPageRoute(
                builder: (context) => EditRecipePage(recipe: recipe, id: id),
                settings: settings,
              );
          }
        },
      ),
    );
  }
}
