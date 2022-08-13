import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount/amount.dart';
import 'ingredient.dart';
import 'temperature/temperature.dart';

part 'direction.freezed.dart';

@freezed
class Direction with _$Direction {
  const factory Direction({
    required String description,
    @Default({}) Map<Ingredient, Mass> massByIngredient,
    @Default({}) Map<Ingredient, Volume> volumeByIngredient,
    @Default({}) Map<Ingredient, Count> countByIngredient,
    @Default(Duration()) Duration time,
    Temperature? temperature,
  }) = _Direction;
}
