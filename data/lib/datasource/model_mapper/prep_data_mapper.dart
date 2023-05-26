part of 'model_mapper.dart';

extension PrepDataExtension on PrepData {
  Amount getAmount() {
    if (unit.isMilligram) return Milligram(value);
    if (unit.isGram) return Gram(value);
    if (unit.isKilogram) return Kilogram(value);
    if (unit.isOunce) return Ounce(value);
    if (unit.isPound) return Pound(value);
    if (unit.isCubicCentimeter) return CubicCentimeter(value);
    if (unit.isMilliliter) return Milliliter(value);
    if (unit.isLiter) return Liter(value);
    if (unit.isTeaspoon) return Teaspoon(value);
    if (unit.isTablespoon) return Tablespoon(value);
    if (unit.isFluidOunce) return FluidOunce(value);
    if (unit.isCup) return Cup(value);
    if (unit.isCount) return Count(value);
    throw StateError('Unsupported enum ${unit.runtimeType}');
  }
}
