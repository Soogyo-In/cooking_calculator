import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../recipe_provider.dart';
import '../edit.dart';

class EditRecipePage extends StatelessWidget {
  static const routeName = 'editRecipe';

  const EditRecipePage.create({
    super.key,
    this.recipe = const Recipe(),
  }) : id = null;

  EditRecipePage.modify({
    super.key,
    required StoredRecipe this.recipe,
  }) : id = recipe.id;

  final int? id;

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        recipeProvider.overrideWith((ref) => recipe),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('레시피 추가')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: RecipeForm(),
        ),
      ),
    );
  }
}
