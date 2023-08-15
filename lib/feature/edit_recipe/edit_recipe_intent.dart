part of 'edit_recipe_feature.dart';

class EditRecipeIntent extends AutoDisposeNotifier<EditRecipeState> {
  @override
  EditRecipeState build() => const EditRecipeState();

  Future<void> addRecipe(Recipe recipe) async {
    try {
      state = state.copyWith(isLoading: true);

      final datasource = await ref.read(recipeLocalDatasourceProvider.future);
      await datasource.addRecipe(recipe);
    } catch (exception) {
      ref.read(editRecipeEffectProvider.notifier).update(
            (state) => EditRecipeEffect.showErrorSnackBar(
              exception.toString(),
            ),
          );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateRecipe({required int id, required Recipe recipe}) async {
    try {
      state = state.copyWith(isLoading: true);

      final datasource = await ref.read(recipeLocalDatasourceProvider.future);
      await datasource.updateRecipe(id: id, recipe: recipe);
    } catch (exception) {
      ref.read(editRecipeEffectProvider.notifier).update(
            (state) => EditRecipeEffect.showErrorSnackBar(exception.toString()),
          );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      state = state.copyWith(isLoading: true);

      final datasource = await ref.read(recipeLocalDatasourceProvider.future);
      await datasource.deleteRecipe(id);
    } catch (exception) {
      ref.read(editRecipeEffectProvider.notifier).update(
            (state) => EditRecipeEffect.showErrorSnackBar(exception.toString()),
          );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
