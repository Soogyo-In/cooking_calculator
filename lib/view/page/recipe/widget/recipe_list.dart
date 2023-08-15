part of '../recipe_list_page.dart';

class _RecipeList extends ConsumerStatefulWidget {
  const _RecipeList(this.recipes);

  const factory _RecipeList.error(Object error, StackTrace stackTrace) =
      _RecipeListError;

  const factory _RecipeList.loading() = _RecipeListLoading;

  final List<StoredRecipe> recipes;

  @override
  ConsumerState<_RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends ConsumerState<_RecipeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        final recipe = widget.recipes.elementAt(index);
        final ingredients = recipe.directions
            .expand((direction) => direction.preps)
            .map((prep) => prep.ingredient);

        return Card(
          child: InkWell(
            onTap: () => _onRecipeCardTapped(context, recipe),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(recipe.name),
                      Wrap(
                        children: ingredients
                            .map((ingredient) =>
                                Chip(label: Text(ingredient.name)))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _onEditButtonPressed(recipe),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  void _onRecipeCardTapped(BuildContext context, Recipe recipe) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RecipePage(recipe: recipe),
    ));
  }

  void _onEditButtonPressed(StoredRecipe recipe) {
    Navigator.maybeOf(context)?.pushNamed(
      EditRecipePage.routeName,
      arguments: (recipe: recipe),
    );
  }
}
