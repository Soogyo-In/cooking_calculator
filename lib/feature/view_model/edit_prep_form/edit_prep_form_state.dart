part of 'edit_prep_form_view_model.dart';

@freezed
class EditPrepFromState with _$EditPrepFromState {
  const EditPrepFromState._();

  const factory EditPrepFromState({
    Ingredient? ingredient,
    @Default([]) List<Ingredient> ingredientSearchSuggestions,
    AmountUnit? amountUnit,
    @Default(0.0) double amountValue,
  }) = _EditPrepFormState;

  bool get isValidAmountUnit => amountUnit != null;

  bool get isValid => isValidAmountUnit;
}
