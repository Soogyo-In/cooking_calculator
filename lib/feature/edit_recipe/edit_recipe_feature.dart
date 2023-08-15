import 'dart:async';

import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_recipe_effect.dart';
part 'edit_recipe_feature.freezed.dart';
part 'edit_recipe_intent.dart';
part 'edit_recipe_state.dart';

final editRecipeIntentProvider =
    NotifierProvider.autoDispose<EditRecipeIntent, EditRecipeState>(
  EditRecipeIntent.new,
);

final editRecipeEffectProvider =
    StateProvider.autoDispose<EditRecipeEffect?>((ref) => null);
