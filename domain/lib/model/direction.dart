import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount/amount.dart';
import 'ingredient.dart';
import 'temperature/temperature.dart';

part 'direction.freezed.dart';

@freezed
class Direction with _$Direction {
  const Direction._();

  const factory Direction({
    required String description,
    @Default({}) Map<Ingredient, Mass> massByIngredient,
    @Default({}) Map<Ingredient, Volume> volumeByIngredient,
    @Default({}) Map<Ingredient, Count> countByIngredient,
    @Default(Duration()) Duration time,
    Temperature? temperature,
  }) = _Direction;

  Map<Ingredient, Mass> getMassByIngredientWithRatio(double ratio) {
    final calculated = <Ingredient, Mass>{};

    massByIngredient.forEach((ingredient, mass) {
      calculated[ingredient] = (mass * ratio) as Mass;
    });

    return calculated;
  }

  Map<Ingredient, Volume> getVolumeByIngredientWithRatio(double ratio) {
    final calculated = <Ingredient, Volume>{};

    volumeByIngredient.forEach((ingredient, volume) {
      calculated[ingredient] = (volume * ratio) as Volume;
    });

    return calculated;
  }

  Map<Ingredient, Count> getCountByIngredientWithRatio(double ratio) {
    final calculated = <Ingredient, Count>{};

    countByIngredient.forEach((ingredient, amount) {
      calculated[ingredient] = amount * ratio;
    });

    return calculated;
  }
}
