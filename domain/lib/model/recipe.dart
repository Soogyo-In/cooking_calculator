import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';

@freezed
abstract class Recipe with _$Recipe {
  const Recipe._();

  const factory Recipe({
    required String name,
    required List<Direction> directions,
    @Default(1) int servings,
    @Default('') String description,
  }) = _Recipe;

  const factory Recipe.indexed({
    required int id,
    required String name,
    required List<Direction> directions,
    @Default(1) int servings,
    @Default('') String description,
  }) = IndexedRecipe;

  Map<int, Mass> get massByIngredientId {
    final merged = <int, Mass>{};

    for (final direction in directions) {
      direction.massByIngredientId.forEach((ingredientId, mass) {
        merged.update(
          ingredientId,
          (value) => (value + mass) as Mass,
          ifAbsent: () => mass,
        );
      });
    }

    return merged;
  }

  Map<int, Volume> get volumeByIngredientId {
    final merged = <int, Volume>{};

    for (final direction in directions) {
      direction.volumeByIngredientId.forEach((ingredientId, volume) {
        merged.update(
          ingredientId,
          (value) => (value + volume) as Volume,
          ifAbsent: () => volume,
        );
      });
    }

    return merged;
  }

  Map<int, Count> get countByIngredientId {
    final merged = <int, Count>{};

    for (final direction in directions) {
      direction.countByIngredientId.forEach((ingredientId, count) {
        merged.update(
          ingredientId,
          (value) => value + count,
          ifAbsent: () => count,
        );
      });
    }

    return merged;
  }

  Duration get time => directions.fold(
        const Duration(),
        (time, direction) => time + direction.time,
      );

  Map<int, Mass> getMassByIngredientWithRatio(double ratio) {
    final calculated = <int, Mass>{};

    for (final direction in directions) {
      direction
          .getMassByIngredientWithRatio(ratio)
          .forEach((ingredientId, mass) => calculated.update(
                ingredientId,
                (value) => (value + mass) as Mass,
                ifAbsent: () => mass,
              ));
    }

    return calculated;
  }

  Map<int, Volume> getVolumeByIngredientWithRatio(double ratio) {
    final calculated = <int, Volume>{};

    for (final direction in directions) {
      direction
          .getVolumeByIngredientWithRatio(ratio)
          .forEach((ingredientId, volume) => calculated.update(
                ingredientId,
                (value) => (value + volume) as Volume,
                ifAbsent: () => volume,
              ));
    }

    return calculated;
  }

  Map<int, Count> getCountByIngredientWithRatio(double ratio) {
    final calculated = <int, Count>{};

    for (final direction in directions) {
      direction
          .getCountByIngredientWithRatio(ratio)
          .forEach((ingredientId, count) => calculated.update(
                ingredientId,
                (value) => value + count,
                ifAbsent: () => count,
              ));
    }

    return calculated;
  }
}
