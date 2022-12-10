import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';

@freezed
class Recipe with _$Recipe {
  const Recipe._();

  const factory Recipe({
    int? id,
    required String name,
    required List<Direction> directions,
    @Default(1) int servings,
    @Default('') String description,
  }) = _Recipe;

  Map<Ingredient, Mass> get massByIngredient {
    final merged = <Ingredient, Mass>{};

    for (final direction in directions) {
      direction.massByIngredient.forEach((ingredient, mass) {
        merged.update(
          ingredient,
          (value) => (value + mass) as Mass,
          ifAbsent: () => mass,
        );
      });
    }

    return merged;
  }

  Map<Ingredient, Volume> get volumeByIngredient {
    final merged = <Ingredient, Volume>{};

    for (final direction in directions) {
      direction.volumeByIngredient.forEach((ingredient, volume) {
        merged.update(
          ingredient,
          (value) => (value + volume) as Volume,
          ifAbsent: () => volume,
        );
      });
    }

    return merged;
  }

  Map<Ingredient, Count> get countByIngredient {
    final merged = <Ingredient, Count>{};

    for (final direction in directions) {
      direction.countByIngredient.forEach((ingredient, count) {
        merged.update(
          ingredient,
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

  Map<Ingredient, Mass> getMassByIngredientWithRatio(double ratio) {
    final calculated = <Ingredient, Mass>{};

    for (final direction in directions) {
      direction
          .getMassByIngredientWithRatio(ratio)
          .forEach((ingredient, mass) => calculated.update(
                ingredient,
                (value) => (value + mass) as Mass,
                ifAbsent: () => mass,
              ));
    }

    return calculated;
  }

  Map<Ingredient, Volume> getVolumeByIngredientWithRatio(double ratio) {
    final calculated = <Ingredient, Volume>{};

    for (final direction in directions) {
      direction
          .getVolumeByIngredientWithRatio(ratio)
          .forEach((ingredient, volume) => calculated.update(
                ingredient,
                (value) => (value + volume) as Volume,
                ifAbsent: () => volume,
              ));
    }

    return calculated;
  }

  Map<Ingredient, Count> getCountByIngredientWithRatio(double ratio) {
    final calculated = <Ingredient, Count>{};

    for (final direction in directions) {
      direction
          .getCountByIngredientWithRatio(ratio)
          .forEach((ingredient, count) => calculated.update(
                ingredient,
                (value) => value + count,
                ifAbsent: () => count,
              ));
    }

    return calculated;
  }
}
