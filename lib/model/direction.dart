import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount/amount.dart';
import 'ingredient.dart';
import 'temperature/temperature.dart';

part 'direction.freezed.dart';

@freezed
class Direction<T extends Amount> with _$Direction<T> {
  const factory Direction({
    required String description,
    @Default({}) Map<Ingredient, T> amountByIngredient,
    @Default({}) Map<Ingredient, double> countByIngredient,
    @Default(Duration()) Duration time,
    Temperature? temperature,
  }) = _Direction;
}
