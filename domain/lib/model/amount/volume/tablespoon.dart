part of 'volume.dart';

const tablespoonSymbol = 'Tbsp';

final class Tablespoon extends Volume {
  Tablespoon(double value)
      : _inMilliliters = (milliliterPerTablespoon * value).round(),
        super(
          symbol: tablespoonSymbol,
          value: value,
        );

  @override
  final int _inMilliliters;

  @override
  CubicCentimeter toCubicCentimeter() =>
      CubicCentimeter((milliliterPerTablespoon * value).round());

  @override
  Cup toCup() => Cup(cupPerTablespoon * value);

  @override
  FluidOunce toFluidOunce() => FluidOunce(fluidOuncePerTablespoon * value);

  @override
  Liter toLiter() => Liter(literPerTablespoon * value);

  @override
  Milliliter toMilliliter() =>
      Milliliter((milliliterPerTablespoon * value).round());

  @override
  Tablespoon toTablespoon() => Tablespoon(value);

  @override
  Teaspoon toTeaspoon() => Teaspoon(teaspoonPerTablespoon * value);

  @override
  Tablespoon roundedAt(int fractionDigits) =>
      Tablespoon(value.roundAt(fractionDigits));

  @override
  Tablespoon operator +(Volume other) =>
      Tablespoon(value + other.toTablespoon().value);

  @override
  Tablespoon operator -(Volume other) =>
      Tablespoon(value - other.toTablespoon().value);

  @override
  Tablespoon operator *(num factor) => Tablespoon(value * factor);

  @override
  Tablespoon operator /(num divisor) => Tablespoon(value / divisor);

  @override
  Tablespoon copyWith({covariant double? value}) =>
      Tablespoon(value ?? this.value);
}
