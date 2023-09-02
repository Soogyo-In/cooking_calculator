import 'package:data/model/model.dart';
import 'package:domain/domain.dart' as domain;
import 'package:test/test.dart';

void main() {
  group(
    'Data prep',
    () {
      test(
        'should convert to domain prep',
        () {
          final prep = Prep(
            unit: MatterUnit.count,
            value: 0,
          );
          final ingredient = Ingredient(
            id: 1,
            name: 'name',
            description: 'description',
          );

          expect(
            prep.toDomainModel(ingredient),
            domain.Prep<domain.Amount>(
              ingredient: domain.StoredIngredient(
                id: ingredient.id,
                name: ingredient.name,
                description: ingredient.description,
              ),
              amount: domain.Count(0),
            ),
          );
        },
      );

      group(
        'should convert to',
        () {
          test(
            'Milligram if unit is milligram',
            () {
              final prep = Prep(
                unit: MatterUnit.milligram,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Milligram(0),
              );
            },
          );

          test(
            'Gram if unit is gram',
            () {
              final prep = Prep(
                unit: MatterUnit.gram,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Gram(0.0),
              );
            },
          );

          test(
            'Kilogram if unit is kilogram',
            () {
              final prep = Prep(
                unit: MatterUnit.kilogram,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Kilogram(0.0),
              );
            },
          );

          test(
            'Ounce if unit is ounce',
            () {
              final prep = Prep(
                unit: MatterUnit.ounce,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Ounce(0.0),
              );
            },
          );

          test(
            'Pound if unit is pound',
            () {
              final prep = Prep(
                unit: MatterUnit.pound,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Pound(0.0),
              );
            },
          );

          test(
            'CubicCentimeter if unit is cubicCentimeter',
            () {
              final prep = Prep(
                unit: MatterUnit.cubicCentimeter,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.CubicCentimeter(0),
              );
            },
          );

          test(
            'Milliliter if unit is milliliter',
            () {
              final prep = Prep(
                unit: MatterUnit.milliliter,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Milliliter(0),
              );
            },
          );

          test(
            'Liter if unit is liter',
            () {
              final prep = Prep(
                unit: MatterUnit.liter,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Liter(0.0),
              );
            },
          );

          test(
            'Teaspoon if unit is teaspoon',
            () {
              final prep = Prep(
                unit: MatterUnit.teaspoon,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Teaspoon(0.0),
              );
            },
          );

          test(
            'Tablespoon if unit is tablespoon',
            () {
              final prep = Prep(
                unit: MatterUnit.tablespoon,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Tablespoon(0.0),
              );
            },
          );

          test(
            'FluidOunce if unit is fluidOunce',
            () {
              final prep = Prep(
                unit: MatterUnit.fluidOunce,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.FluidOunce(0.0),
              );
            },
          );

          test(
            'Cup if unit is cup',
            () {
              final prep = Prep(
                unit: MatterUnit.cup,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Cup(0.0),
              );
            },
          );

          test(
            'Count if unit is count',
            () {
              final prep = Prep(
                unit: MatterUnit.count,
                value: 0.0,
              );
              expect(
                prep.toAmount(),
                domain.Count(0.0),
              );
            },
          );
        },
      );
    },
  );

  group(
    'Domain prep',
    () {
      test(
        'should convert to data prep',
        () {
          final prep = domain.Prep(
            amount: domain.Count(0),
            ingredient: domain.Ingredient(
              name: 'name',
              description: 'description',
            ),
          );
          final ingredientId = 0;
          final dataPrep = prep.toDataModel(ingredientId);

          expect(dataPrep.ingredientId, ingredientId);
          expect(dataPrep.unit, MatterUnit.count);
          expect(dataPrep.value, 0);
        },
      );
    },
  );
}
