import 'dart:async';

import 'package:cooking_calulator/model/model.dart';
import 'package:cooking_calulator/provider/provider.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_prep_form_effect.dart';
part 'edit_prep_form_intent.dart';
part 'edit_prep_form_feature.freezed.dart';
part 'edit_prep_form_state.dart';

final editPrepFormIntentProvider = NotifierProvider.autoDispose
    .family<EditPrepFormIntent, EditPrepFormState, Prep?>(
  EditPrepFormIntent.new,
);

final editPrepFormEffectProvider =
    StateProvider.autoDispose<EditPrepFormEffect?>((ref) => null);
