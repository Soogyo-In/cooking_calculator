import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_recipe_form_feature.freezed.dart';
part 'edit_recipe_form_intent.dart';
part 'edit_recipe_form_state.dart';

final editRecipeFormIntentProvider = NotifierProvider.autoDispose
    .family<EditRecipeFormIntent, EditRecipeFormState, Recipe?>(
  EditRecipeFormIntent.new,
);
