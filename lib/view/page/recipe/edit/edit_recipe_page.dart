import 'package:cooking_calulator/feature/feature.dart';
import 'package:cooking_calulator/view/view.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef EditRecipePageArguments = ({StoredRecipe? recipe});

class EditRecipePage extends ConsumerStatefulWidget {
  static const routeName = '/editRecipe';

  const EditRecipePage({super.key, this.recipe});

  final StoredRecipe? recipe;

  @override
  ConsumerState<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends ConsumerState<EditRecipePage> {
  @override
  Widget build(BuildContext context) {
    ref.listen<EditRecipeEffect?>(editRecipeEffectProvider, _onEffect);

    final state = ref.watch(editRecipeIntentProvider);
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: const Text('레시피 추가'),
        actions: recipe != null
            ? [
                IconButton(
                  onPressed: () => _onDeleteButtonPressed(recipe.id),
                  icon: const Icon(Icons.delete_forever),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: RecipeForm(
            recipe: widget.recipe,
            onSubmitted: state.isLoading ? null : _onRecipeSubmitted,
          ),
        ),
      ),
    );
  }

  void _onEffect(EditRecipeEffect? previous, EditRecipeEffect? next) {
    switch (next) {
      case EditRecipeShowErrorSnackBar():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      case EditRecipeNavigateBack():
        Navigator.maybeOf(context)?.maybePop();
    }
  }

  void _onRecipeSubmitted(Recipe recipe) {
    final intent = ref.read(editRecipeIntentProvider.notifier);

    final originalRecipe = widget.recipe;
    if (originalRecipe == null) {
      intent.addRecipe(recipe);
      return;
    }

    intent.updateRecipe(id: originalRecipe.id, recipe: recipe);
  }

  void _onDeleteButtonPressed(int id) {
    ref.read(editRecipeIntentProvider.notifier).deleteRecipe(id);
  }
}
