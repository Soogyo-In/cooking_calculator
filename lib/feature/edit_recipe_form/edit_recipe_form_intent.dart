part of 'edit_recipe_form_feature.dart';

class EditRecipeFormIntent
    extends AutoDisposeFamilyNotifier<EditRecipeFormState, Recipe?> {
  @override
  EditRecipeFormState build(Recipe? arg) {
    return arg == null
        ? const EditRecipeFormState()
        : EditRecipeFormState(
            description: arg.description,
            directions: arg.directions,
            name: arg.name,
            servings: arg.servings,
          );
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void changeDirection({
    required Direction previous,
    required Direction changed,
  }) {
    state = state.copyWith(
      directions: state.directions
          .map(
            (direction) => direction == previous ? changed : direction,
          )
          .toList(),
    );
  }

  void addDirection(Direction direction) {
    state =
        state.copyWith(directions: state.directions.toList()..add(direction));
  }

  void insertDirection(int at, Direction direction) {
    state = state.copyWith(
      directions: state.directions.toList()..insert(at, direction),
    );
  }

  void reorderDirection(int oldIndex, int newIndex) {
    oldIndex = oldIndex.clamp(0, state.directions.length - 1);
    newIndex = newIndex.clamp(0, state.directions.length - 1);

    if (oldIndex == newIndex) return;

    final reordered = state.directions.toList();
    final direction = reordered.removeAt(oldIndex);
    reordered.insert(newIndex, direction);

    state = state.copyWith(directions: reordered);
  }

  void removeDirection(Direction direction) {
    state = state.copyWith(
        directions: state.directions.toList()..remove(direction));
  }

  void setServings(int servings) {
    if (servings < 1) servings = 1;

    state = state.copyWith(servings: servings);
  }
}
