part of 'volume.dart';

const fluidOunceSymbol = 'fl.oz';

final class FluidOunce extends Volume {
  FluidOunce(double value)
      : _inMilliliters = (milliliterPerFluidOunce * value).round(),
        super(
          symbol: fluidOunceSymbol,
          value: value,
        );

  @override
  final int _inMilliliters;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter((milliliterPerFluidOunce * value).round());

  @override
  Cup toCup() => Cup(cupPerFluidOunce * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(value);

  @override
  Liter toLiter() => Liter(literPerFluidOunce * value);

  @override
  Milliliter toMilliliter() =>
      Milliliter((milliliterPerFluidOunce * value).round());

  @override
  Tablespoon toTablespoon() => Tablespoon(tablespoonPerFluidOunce * value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerFluidOunce * value);

  @override
  FluidOunce roundedAt(int fractionDigits) =>
      FluidOunce(value.roundAt(fractionDigits));

  @override
  FluidOunce operator +(Volume other) =>
      FluidOunce(value + other.toFluidOunce().value);

  @override
  FluidOunce operator -(Volume other) =>
      FluidOunce(value - other.toFluidOunce().value);

  @override
  FluidOunce operator *(num factor) => FluidOunce(value * factor);

  @override
  FluidOunce operator /(num divisor) => FluidOunce(value / divisor);

  @override
  FluidOunce copyWith({covariant double? value}) =>
      FluidOunce(value ?? this.value);
}
