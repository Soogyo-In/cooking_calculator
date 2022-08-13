import 'package:freezed_annotation/freezed_annotation.dart';

import 'amount/amount.dart';
import 'direction.dart';
import 'ingredient.dart';

part 'recipe.freezed.dart';

@freezed
class Recipe with _$Recipe {
  const Recipe._();

  const factory Recipe({
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

  Map<Ingredient, Mass> getMassByIngredientServingsFor(int servings) {
    final calculated = <Ingredient, Mass>{};

    massByIngredient.forEach((ingredient, mass) {
      calculated[ingredient] = (mass * (servings / this.servings)) as Mass;
    });

    return calculated;
  }

  Map<Ingredient, Volume> getVolumeByIngredientServingsFor(int servings) {
    final calculated = <Ingredient, Volume>{};

    volumeByIngredient.forEach((ingredient, volume) {
      calculated[ingredient] = (volume * (servings / this.servings)) as Volume;
    });

    return calculated;
  }

  Map<Ingredient, Count> getCountByIngredientServingsFor(int servings) {
    final calculated = <Ingredient, Count>{};

    countByIngredient.forEach((ingredient, amount) {
      calculated[ingredient] = amount * (servings / this.servings);
    });

    return calculated;
  }
}
