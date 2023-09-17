part of 'search_recipes_feature.dart';

class SearchRecipesIntent extends AutoDisposeNotifier<SearchRecipesState> {
  @override
  SearchRecipesState build() {
    return const SearchRecipesState();
  }

  Future<void> setPage({int page = 0, int size = 0}) async {
    await _stateTransaction(
      process: Future(() async {
        state = state.copyWith(isLoading: true, size: size, page: page);
        state = state.copyWith(
          isLoading: false,
          recipes: await _searchRecipes(state),
        );
      }),
      onError: _onError,
    );
  }

  Future<void> setName(String name) async {
    await _stateTransaction(
      process: Future(() async {
        state = state.copyWith(isLoading: true, name: name);
        state = state.copyWith(
          isLoading: false,
          recipes: await _searchRecipes(state),
        );
      }),
      onError: _onError,
    );
  }

  Future<void> setIngredientIds(List<int> ingredientIds) async {
    await _stateTransaction(
      process: Future(() async {
        state = state.copyWith(isLoading: true, ingredientIds: ingredientIds);
        state = state.copyWith(
          isLoading: false,
          recipes: await _searchRecipes(state),
        );
      }),
      onError: _onError,
    );
  }

  Future<void> setCookingTime(Duration cookingTime) async {
    await _stateTransaction(
      process: Future(() async {
        state = state.copyWith(isLoading: true, cookingTime: cookingTime);
        state = state.copyWith(
          isLoading: false,
          recipes: await _searchRecipes(state),
        );
      }),
      onError: _onError,
    );
  }

  Future<List<StoredRecipe>> _searchRecipes(SearchRecipesState state) async {
    final datasource = await ref.read(recipeLocalDatasourceProvider.future);
    return datasource.searchRecipes(
      cookingTime: state.cookingTime,
      ingredientIds: state.ingredientIds,
      name: state.name,
      page: state.page,
      size: state.size,
    );
  }

  Future<void> _stateTransaction({
    required Future process,
    Function(Object)? onError,
  }) async {
    final previousState = state;
    try {
      await process;
    } catch (e) {
      state = previousState;
      onError?.call(e);
    }
  }

  void _onError(Object error) {
    ref.read(searchRecipesEffectProvider.notifier).state =
        SearchRecipesEffect.showErrorSnackBar(error.toString());
  }
}
