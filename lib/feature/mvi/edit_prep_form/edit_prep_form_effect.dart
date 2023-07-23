part of 'edit_prep_form_mvi.dart';

@freezed
class EditPrepFormEffect with _$EditPrepFormEffect {
  const factory EditPrepFormEffect.showErrorSnackBar(
    String message,
  ) = ShowErrorSnackBar;
}
