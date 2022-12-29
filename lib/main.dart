import 'package:collection/collection.dart';
import 'package:cooking_calulator/recipe_resource.dart';
import 'package:cooking_calulator/page/recipe/recipe_page.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Recipe> recipes = [];
  Map<int, Ingredient> ingredientById = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking Calculator',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('레시피'),
            ),
            body: ListView.separated(
              shrinkWrap: true,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                final ingredientIdSet = {
                  ...recipe.countByIngredientId.keys,
                  ...recipe.massByIngredientId.keys,
                  ...recipe.volumeByIngredientId.keys,
                };
                return Card(
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecipePage(
                        recipe: slowRoasetedPorkBellyRecipe,
                      ),
                    )),
                    child: Column(
                      children: [
                        Text(recipe.name),
                        Wrap(
                          children: ingredientIdSet
                              .map((id) => ingredientById[id]?.name)
                              .whereNotNull()
                              .map((name) => Chip(label: Text(name)))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      ),
    );
  }
}
