import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    int? id,
    required String name,
    @Default('') String description,
  }) = _Ingredient;
}
