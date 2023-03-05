import 'package:collection/collection.dart';
import 'package:cooking_calulator/page/recipe/recipe_page.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add/recipe_add_title_page.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레시피'),
      ),
      body: const _RecipeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddRecpieButtonPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddRecpieButtonPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RecipeAddTitlePage(),
    ));
  }
}

class _RecipeList extends ConsumerWidget {
  const _RecipeList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(cachedRecipeRepositoryProvider).when(
          data: (data) {
            final recipes = data.values;
            return ListView.separated(
              shrinkWrap: true,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes.elementAt(index);
                final ingredientIdSet = {
                  ...recipe.countByIngredientId.keys,
                  ...recipe.massByIngredientId.keys,
                  ...recipe.volumeByIngredientId.keys,
                };

                return Card(
                  child: InkWell(
                    onTap: () => _onRecipeCardTapped(context, recipe),
                    child: Column(
                      children: [
                        Text(recipe.name),
                        ref.watch(cachedIngredientRepositoryProvider).when(
                              data: (data) {
                                return Wrap(
                                  children: ingredientIdSet
                                      .map((id) => data[id]?.name)
                                      .whereNotNull()
                                      .map((name) => Chip(label: Text(name)))
                                      .toList(),
                                );
                              },
                              error: (error, stackTrace) =>
                                  Center(child: Text(error.toString())),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }

  void _onRecipeCardTapped(BuildContext context, Recipe recipe) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RecipePage(recipe: recipe),
    ));
  }
}
