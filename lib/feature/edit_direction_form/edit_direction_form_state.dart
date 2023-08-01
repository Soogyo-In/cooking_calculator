part of 'edit_direction_form_feature.dart';

@freezed
class EditDirectionFormState with _$EditDirectionFormState {
  const factory EditDirectionFormState({
    @Default('') String description,
    @Default([]) List<Prep> preps,
    @Default(Duration.zero) Duration time,
    Temperature? temperature,
  }) = _EditDirectionFormState;
}
