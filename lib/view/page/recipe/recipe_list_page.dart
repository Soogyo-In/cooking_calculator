import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit/edit.dart';
import 'recipe_page.dart';
import 'recipe_provider.dart';

part 'widget/recipe_list.dart';
part 'widget/recipe_list_error.dart';
part 'widget/recipe_list_loading.dart';

class RecipeListPage extends ConsumerWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레시피'),
      ),
      body: ref.watch(recipeListProvider).when(
            data: _RecipeList.new,
            error: _RecipeList.error,
            loading: _RecipeList.loading,
          ),
      floatingActionButton: ref.watch(recipeListProvider).when(
            data: (data) => FloatingActionButton(
              onPressed: () => _onAddRecpieButtonPressed(context),
              child: const Icon(Icons.add),
            ),
            error: (error, stackTrace) => null,
            loading: () => null,
          ),
    );
  }

  void _onAddRecpieButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(EditRecipePage.routeName);
  }
}
