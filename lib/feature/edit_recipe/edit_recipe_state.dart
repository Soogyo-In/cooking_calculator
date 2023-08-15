part of 'edit_recipe_feature.dart';

@freezed
class EditRecipeState with _$EditRecipeState {
  const factory EditRecipeState({
    @Default(false) bool isLoading,
  }) = _EditRecipeState;
}
