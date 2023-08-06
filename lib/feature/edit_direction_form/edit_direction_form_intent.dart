part of 'edit_direction_form_feature.dart';

class EditDirectionFormIntent
    extends AutoDisposeFamilyNotifier<EditDirectionFormState, Direction?> {
  @override
  EditDirectionFormState build(Direction? arg) {
    return arg == null
        ? const EditDirectionFormState()
        : EditDirectionFormState(
            description: arg.description,
            preps: arg.preps,
            temperature: arg.temperature,
            time: arg.time,
          );
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void changePrep({required Prep previous, required Prep next}) {
    state = state.copyWith(
      preps: state.preps.map((prep) => prep == previous ? next : prep).toList(),
    );
  }

  void addPrep(Prep prep) {
    state = state.copyWith(preps: state.preps.toList()..add(prep));
  }

  void removePrep(Prep prep) {
    state = state.copyWith(preps: state.preps.toList()..remove(prep));
  }

  void setTemperature(Temperature temperature) {
    state = state.copyWith(temperature: temperature);
  }

  void clearTemperature() {
    state = state.copyWith(temperature: null);
  }

  void setTime(Duration time) {
    state = state.copyWith(time: time);
  }
}
