import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_recipes_effect.dart';
part 'search_recipes_feature.freezed.dart';
part 'search_recipes_intent.dart';
part 'search_recipes_state.dart';

final searchRecipesIntentProvider =
    NotifierProvider.autoDispose<SearchRecipesIntent, SearchRecipesState>(
  SearchRecipesIntent.new,
);

final searchRecipesEffectProvider =
    StateProvider.autoDispose<SearchRecipesEffect?>((ref) => null);
