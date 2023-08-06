part of 'edit_prep_form_feature.dart';

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

  Amount? get amount => amountUnit?.toAmount(amountValue);

  Prep? get prep {
    final amount = this.amount;
    final ingredient = this.ingredient;

    if (amount == null || ingredient == null) return null;

    return Prep(amount: amount, ingredient: ingredient);
  }
}
