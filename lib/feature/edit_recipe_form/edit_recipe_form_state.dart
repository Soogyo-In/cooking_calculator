part of 'edit_recipe_form_feature.dart';

@freezed
class EditRecipeFormState with _$EditRecipeFormState {
  const EditRecipeFormState._();

  const factory EditRecipeFormState({
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<Direction> directions,
    @Default(ServingUnit.portion) ServingUnit servingUnit,
    @Default(1) int servings,
  }) = _EditRecipeFormState;

  bool get isValid => name.isNotEmpty && directions.isNotEmpty && servings > 0;

  Recipe get recipe => Recipe(
        description: description,
        directions: directions,
        name: name,
        servingUnit: servingUnit,
        servings: servings,
      );
}
