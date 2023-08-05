part of 'edit_recipe_form_feature.dart';

@freezed
class EditRecipeFormState with _$EditRecipeFormState {
  const factory EditRecipeFormState({
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<Direction> directions,
    @Default(1) int servings,
  }) = _EditRecipeFormState;
}
