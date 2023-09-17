part of 'search_recipes_feature.dart';

@freezed
class SearchRecipesState with _$SearchRecipesState {
  const factory SearchRecipesState({
    @Default(false) final bool isLoading,
    @Default([]) final List<StoredRecipe> recipes,
    @Default(0) final int page,
    @Default(0) final int size,
    @Default('') final String name,
    @Default([]) final List<int> ingredientIds,
    final Duration? cookingTime,
  }) = _SearchRecipesState;
}
