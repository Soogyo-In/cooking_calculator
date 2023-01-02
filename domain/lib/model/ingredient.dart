import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    @Default('') String description,
  }) = _Ingredient;

  const factory Ingredient.indexed({
    required int id,
    required String name,
    @Default('') String description,
  }) = IndexedIngredient;
}
