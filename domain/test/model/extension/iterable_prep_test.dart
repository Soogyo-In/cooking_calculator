import 'package:domain/model/extension/extension.dart';
import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  test('Should return preps summary', () {
    final preps = [
      Prep(ingredient: Ingredient(name: '1'), amount: Mass.gram(1.0)),
      Prep(ingredient: Ingredient(name: '1'), amount: Mass.milligram(1)),
      Prep(ingredient: Ingredient(name: '1'), amount: Volume.liter(1.0)),
      Prep(ingredient: Ingredient(name: '1'), amount: Volume.milliliter(1)),
      Prep(ingredient: Ingredient(name: '1'), amount: Count(1.0)),
      Prep(ingredient: Ingredient(name: '1'), amount: Count(1.0)),
      Prep(ingredient: Ingredient(name: '2'), amount: Mass.gram(1.0)),
      Prep(ingredient: Ingredient(name: '2'), amount: Mass.milligram(1)),
      Prep(ingredient: Ingredient(name: '2'), amount: Volume.liter(1.0)),
      Prep(ingredient: Ingredient(name: '2'), amount: Volume.milliliter(1)),
      Prep(ingredient: Ingredient(name: '2'), amount: Count(1.0)),
      Prep(ingredient: Ingredient(name: '2'), amount: Count(1.0)),
    ];

    expect(
      preps.sumAmounts(),
      [
        Prep(
          ingredient: Ingredient(name: '1'),
          amount: Mass.milligram(1001),
        ),
        Prep(
          ingredient: Ingredient(name: '1'),
          amount: Volume.milliliter(1001),
        ),
        Prep(
          ingredient: Ingredient(name: '1'),
          amount: Count(2.0),
        ),
        Prep(
          ingredient: Ingredient(name: '2'),
          amount: Mass.milligram(1001),
        ),
        Prep(
          ingredient: Ingredient(name: '2'),
          amount: Volume.milliliter(1001),
        ),
        Prep(
          ingredient: Ingredient(name: '2'),
          amount: Count(2.0),
        ),
      ],
    );
  });

  test('Should return scaled preps', () {
    final preps = [
      Prep(ingredient: Ingredient(name: '1'), amount: Mass.milligram(1)),
      Prep(ingredient: Ingredient(name: '1'), amount: Volume.milliliter(1)),
      Prep(ingredient: Ingredient(name: '1'), amount: Count(1.0)),
    ];

    expect(
      preps.scaleAmounts(2.0),
      [
        Prep<Amount>(
          ingredient: Ingredient(name: '1'),
          amount: Mass.milligram(2),
        ),
        Prep<Amount>(
          ingredient: Ingredient(name: '1'),
          amount: Volume.milliliter(2),
        ),
        Prep<Amount>(
          ingredient: Ingredient(name: '1'),
          amount: Count(2.0),
        ),
      ],
    );
  });
}
