import 'dart:async';

import 'package:cooking_calulator/model/model.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_prep_form_state.dart';
part 'edit_prep_form_view_model.freezed.dart';

final editPrepFormViewModelProvider =
    NotifierProvider.autoDispose<EditPrepFormViewModel, EditPrepFromState>(
  () => EditPrepFormViewModel(),
);

class EditPrepFormViewModel extends AutoDisposeNotifier<EditPrepFromState> {
  EditPrepFormViewModel({Prep<Amount>? prep}) : _prep = prep {
    ingredientSuggestionsSubsciprtion = _searchKeywordStreamController.stream
        .asyncMap(_mapIngredientSearchKeywordToSuggestions)
        .listen(_onIngredientSuggestions);
  }

  final Prep? _prep;

  final _searchKeywordStreamController = StreamController<String>();

  StreamSubscription? ingredientSuggestionsSubsciprtion;

  @override
  EditPrepFromState build() {
    ref.onDispose(() {
      ingredientSuggestionsSubsciprtion?.cancel();
      _searchKeywordStreamController.close();
    });

    return EditPrepFromState(
      amountUnit: _prep?.amount.unit,
      amountValue: _prep?.amount.value ?? 0.0,
      ingredient: _prep?.ingredient,
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
