part of 'edit_direction_form_feature.dart';

@freezed
class EditDirectionFormState with _$EditDirectionFormState {
  const EditDirectionFormState._();

  const factory EditDirectionFormState({
    @Default('') String description,
    @Default([]) List<Prep> preps,
    @Default(Duration.zero) Duration time,
    Temperature? temperature,
  }) = _EditDirectionFormState;

  bool get isValid => description.isNotEmpty;

  Direction get direction => Direction(
        description: description,
        preps: preps,
        cookingTemperature: temperature,
        cookingTime: time,
      );
}
