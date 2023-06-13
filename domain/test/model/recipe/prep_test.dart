import 'package:domain/model/model.dart';
import 'package:test/test.dart';

void main() {
  test('Should return scaled amount', () {
    final prep = Prep(ingredient: Ingredient(name: '1'), amount: Count(1.0));

    expect(
      prep.scaleAmount(2.0),
      Prep<Amount>(ingredient: Ingredient(name: '1'), amount: Count(2.0)),
    );
  });
}
