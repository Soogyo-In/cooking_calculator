import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount/amount.dart';
import 'temperature/temperature.dart';

part 'direction.freezed.dart';

@freezed
class Direction with _$Direction {
  const Direction._();

  const factory Direction({
    required String description,
    @Default({}) Map<int, Mass> massByIngredientId,
    @Default({}) Map<int, Volume> volumeByIngredientId,
    @Default({}) Map<int, Count> countByIngredientId,
    @Default(Duration()) Duration time,
    Temperature? temperature,
  }) = _Direction;

  Map<int, Mass> getMassByIngredientWithRatio(double ratio) {
    final calculated = <int, Mass>{};

    massByIngredientId.forEach((ingredientId, mass) {
      calculated[ingredientId] = (mass * ratio) as Mass;
    });

    return calculated;
  }

  Map<int, Volume> getVolumeByIngredientWithRatio(double ratio) {
    final calculated = <int, Volume>{};

    volumeByIngredientId.forEach((ingredientId, volume) {
      calculated[ingredientId] = (volume * ratio) as Volume;
    });

    return calculated;
  }

  Map<int, Count> getCountByIngredientWithRatio(double ratio) {
    final calculated = <int, Count>{};

    countByIngredientId.forEach((ingredientId, amount) {
      calculated[ingredientId] = amount * ratio;
    });

    return calculated;
  }
}
