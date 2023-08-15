part of 'edit_recipe_feature.dart';

@freezed
class EditRecipeEffect with _$EditRecipeEffect {
  const factory EditRecipeEffect.showErrorSnackBar(
    String message,
  ) = EditRecipeShowErrorSnackBar;

  const factory EditRecipeEffect.navigateBack() = EditRecipeNavigateBack;
}
