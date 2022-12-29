import 'package:collection/collection.dart';
import 'package:cooking_calulator/page/recipe/recipe_page.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'add/recipe_add_title_page.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> recipes = [];
  Map<int, Ingredient> ingredientById = {};

  @override
  Widget build(BuildContext context) {
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
              onTap: () => _onRecipeCardTapped(recipe),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddRecpieButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onRecipeCardTapped(Recipe recipe) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RecipePage(recipe: recipe),
    ));
  }

  void _onAddRecpieButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RecipeAddTitlePage(),
    ));
  }
}
