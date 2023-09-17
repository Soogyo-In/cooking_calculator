part of 'search_recipes_feature.dart';

@freezed
class SearchRecipesEffect with _$SearchRecipesEffect {
  const factory SearchRecipesEffect() = _SearchRecipesEffect;

  const factory SearchRecipesEffect.showErrorSnackBar(
    String message,
  ) = SearchRecipesShowErrorSnackBar;
}
