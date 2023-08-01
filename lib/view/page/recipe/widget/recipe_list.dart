part of '../recipe_list_page.dart';

class _RecipeList extends ConsumerWidget {
  const _RecipeList(this.recipes);

  const factory _RecipeList.error(Object error, StackTrace stackTrace) =
      _RecipeListError;

  const factory _RecipeList.loading() = _RecipeListLoading;

  final List<StoredRecipe> recipes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes.elementAt(index);
        final ingredients = recipe.directions
            .expand((direction) => direction.preps)
            .map((prep) => prep.ingredient);

        return Card(
          child: InkWell(
            onTap: () => _onRecipeCardTapped(context, recipe),
            child: Column(
              children: [
                Text(recipe.name),
                Wrap(
                  children: ingredients
                      .map((ingredient) => Chip(label: Text(ingredient.name)))
                      .toList(),
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
}
