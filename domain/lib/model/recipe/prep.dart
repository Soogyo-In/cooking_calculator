part of 'recipe.dart';

class Prep<T extends Amount> extends Equatable {
  const Prep({
    required this.ingredient,
    required this.amount,
  });

  final Ingredient ingredient;

  final T amount;

  @override
  List<Object?> get props => [ingredient, amount];

  Prep scaleAmount(double scale) => Prep(
        amount: amount * scale,
        ingredient: ingredient,
      );
}
