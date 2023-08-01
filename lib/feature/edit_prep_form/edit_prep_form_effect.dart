part of 'edit_prep_form_feature.dart';

@freezed
class EditPrepFormEffect with _$EditPrepFormEffect {
  const factory EditPrepFormEffect.showErrorSnackBar(
    String message,
  ) = ShowErrorSnackBar;
}
