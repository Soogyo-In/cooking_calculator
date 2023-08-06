import 'package:cooking_calulator/view/view.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';

class EditRecipePage extends StatelessWidget {
  static const routeName = 'editRecipe';

  const EditRecipePage.create({
    super.key,
    this.recipe,
  });

  final Recipe? recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('레시피 추가')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: RecipeForm(
            recipe: recipe,
            onSubmitted: _onRecipeSubmitted,
          ),
        ),
      ),
    );
  }

  void _onRecipeSubmitted(Recipe recipe) {}
}
