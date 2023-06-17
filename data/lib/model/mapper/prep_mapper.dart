part of 'mapper.dart';

extension DataPrepMapper on Prep {
  domain.Prep toDomainModel(domain.Ingredient ingredient) => domain.Prep(
        amount: toAmount(),
        ingredient: ingredient,
      );

  domain.Amount toAmount() {
    if (unit.isMilligram) return domain.Milligram(value.toInt());
    if (unit.isGram) return domain.Gram(value);
    if (unit.isKilogram) return domain.Kilogram(value);
    if (unit.isOunce) return domain.Ounce(value);
    if (unit.isPound) return domain.Pound(value);
    if (unit.isCubicCentimeter) return domain.CubicCentimeter(value.toInt());
    if (unit.isMilliliter) return domain.Milliliter(value.toInt());
    if (unit.isLiter) return domain.Liter(value);
    if (unit.isTeaspoon) return domain.Teaspoon(value);
    if (unit.isTablespoon) return domain.Tablespoon(value);
    if (unit.isFluidOunce) return domain.FluidOunce(value);
    if (unit.isCup) return domain.Cup(value);
    if (unit.isCount) return domain.Count(value);
    throw StateError('Unsupported enum ${unit.runtimeType}');
  }
}

extension DomainPrepMapper on domain.Prep {
  Prep toDataModel(Id ingredientId) => Prep(
        ingredientId: ingredientId,
        unit: amount.toMatterUnit(),
        value: amount.value,
      );
}
