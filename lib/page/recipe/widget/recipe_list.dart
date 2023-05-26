part of '../recipe_list_page.dart';

class _RecipeList extends ConsumerWidget {
  const _RecipeList(this.recipes);

  const factory _RecipeList.error(Object error, StackTrace stackTrace) =
      _RecipeListError;

  const factory _RecipeList.loading() = _RecipeListLoading;

  final List<IndexedRecipe> recipes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ref.watch(ingredientsProvider).when(
                      data: (data) {
                        return Wrap(
                          children: ingredientIdSet
                              .map((id) => data[id].name)
                              .whereNotNull()
                              .map((name) => Chip(label: Text(name)))
                              .toList(),
                        );
                      },
                      error: (error, stackTrace) =>
                          Center(child: Text(error.toString())),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
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
