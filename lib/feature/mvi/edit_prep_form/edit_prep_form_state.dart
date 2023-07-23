part of 'edit_prep_form_mvi.dart';

@freezed
class EditPrepFormState with _$EditPrepFormState {
  const EditPrepFormState._();

  const factory EditPrepFormState({
    Ingredient? ingredient,
    @Default([]) List<Ingredient> ingredientSearchSuggestions,
    AmountUnit? amountUnit,
    @Default(0.0) double amountValue,
    @Default(false) bool isLoading,
  }) = _EditPrepFormState;

  bool get isValidAmountUnit => amountUnit != null;

  bool get isValid => isValidAmountUnit && ingredient != null;
}
