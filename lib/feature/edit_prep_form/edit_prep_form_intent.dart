part of 'edit_prep_form_feature.dart';

class EditPrepFormIntent
    extends AutoDisposeFamilyNotifier<EditPrepFormState, Prep?> {
  EditPrepFormIntent() {
    _ingredientSuggestionsSubsciprtion = _searchKeywordStreamController.stream
        .asyncMap(_mapIngredientSearchKeywordToSuggestions)
        .listen(_onIngredientSuggestions);
  }

  final _searchKeywordStreamController = StreamController<String>();

  StreamSubscription? _ingredientSuggestionsSubsciprtion;

  @override
  EditPrepFormState build(Prep? arg) {
    ref.onDispose(() {
      _ingredientSuggestionsSubsciprtion?.cancel();
      _searchKeywordStreamController.close();
    });

    return EditPrepFormState(
      amountUnit: arg?.amount.unit,
      amountValue: arg?.amount.value ?? 0.0,
      ingredient: arg?.ingredient,
    );
  }

  void updateIngredientSearchSuggestions(String keyword) {
    _searchKeywordStreamController.add(keyword);
  }

  Future<void> submitIngredientName(String name) async {
    try {
      state = state.copyWith(isLoading: true);

      final datasource = await ref.read(recipeLocalDatasourceProvider.future);
      final ingredients = await datasource.searchIngredients(name);

      state = state.copyWith(
        isLoading: false,
        ingredient: ingredients.firstOrNull ?? Ingredient(name: name),
      );
    } catch (error) {
      state = state.copyWith(isLoading: false);
      _onError(error);
    }
  }

  void selectIngredient(Ingredient ingredient) {
    state = state.copyWith(ingredient: ingredient);
  }

  void changeAmountUnit(AmountUnit? unit) {
    state = state.copyWith(amountUnit: unit);
  }

  void changeAmountValue(String value) {
    try {
      if (value.isEmpty) {
        state = state.copyWith(amountValue: 0.0);
        return;
      }

      state = state.copyWith(amountValue: double.parse(value));
    } on FormatException catch (error) {
      _onError(error);
    }
  }

  Future<List<Ingredient>> _mapIngredientSearchKeywordToSuggestions(
    String keyword,
  ) async {
    final datasource = await ref.watch(recipeLocalDatasourceProvider.future);
    return datasource.searchIngredients(keyword);
  }

  void _onIngredientSuggestions(List<Ingredient> suggestions) {
    state = state.copyWith(ingredientSearchSuggestions: suggestions);
  }

  void _onError(Object error) {
    ref
        .read(editPrepFormEffectProvider.notifier)
        .update((state) => EditPrepFormEffect.showErrorSnackBar(
              error.toString(),
            ));
  }
}
