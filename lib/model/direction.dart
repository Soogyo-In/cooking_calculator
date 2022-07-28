import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount/amount.dart';
import 'ingredient.dart';

part 'direction.freezed.dart';

@freezed
class Direction<T extends Amount> with _$Direction {
  const factory Direction({
    required String description,
    @Default({}) Map<Ingredient, T> amountByIngredient,
    @Default(Duration()) Duration time,
  }) = _Direction;
}
