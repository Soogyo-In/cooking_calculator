import 'dart:async';

import 'package:cooking_calulator/model/model.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_prep_form_state.dart';
part 'edit_prep_form_view_model.freezed.dart';

final editPrepFormViewModelProvider = NotifierProvider.autoDispose
    .family<EditPrepFormViewModel, EditPrepFromState, Prep?>(
  EditPrepFormViewModel.new,
);

class EditPrepFormViewModel
    extends AutoDisposeFamilyNotifier<EditPrepFromState, Prep?> {
  EditPrepFormViewModel() {
    _ingredientSuggestionsSubsciprtion = _searchKeywordStreamController.stream
        .asyncMap(_mapIngredientSearchKeywordToSuggestions)
        .listen(_onIngredientSuggestions);
  }

  final _searchKeywordStreamController = StreamController<String>();

  StreamSubscription? _ingredientSuggestionsSubsciprtion;

  @override
  EditPrepFromState build(Prep? arg) {
    ref.onDispose(() {
      _ingredientSuggestionsSubsciprtion?.cancel();
      _searchKeywordStreamController.close();
    });

    return EditPrepFromState(
      amountUnit: arg?.amount.unit,
      amountValue: arg?.amount.value ?? 0.0,
      ingredient: arg?.ingredient,
    );
  }

  void updateIngredientSearchSuggestions(String keyword) {
    _searchKeywordStreamController.add(keyword);
  }

  void submitIngredientName(String name) {
    state = state.copyWith(ingredient: Ingredient(name: name));
  }

  void selectIngredient(Ingredient ingredient) {
    state = state.copyWith(ingredient: ingredient);
  }

  void changeAmountUnit(AmountUnit? unit) {
    state = state.copyWith(amountUnit: unit);
  }

  void changeAmountValue(String value) {
    state = state.copyWith(amountValue: double.tryParse(value) ?? 0.0);
  }

  Future<List<Ingredient>> _mapIngredientSearchKeywordToSuggestions(
    String keyword,
  ) async {
    final datasource = await ref.watch(recipeLocalDatasourceProvider.future);
    return datasource.searchIngredients(name: keyword);
  }

  void _onIngredientSuggestions(List<Ingredient> suggestions) {
    state = state.copyWith(ingredientSearchSuggestions: suggestions);
  }
}
