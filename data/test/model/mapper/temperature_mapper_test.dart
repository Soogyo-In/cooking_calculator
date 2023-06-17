import 'package:data/model/model.dart';
import 'package:domain/domain.dart' as domain;
import 'package:test/test.dart';

void main() {
  group(
    'Data temperature can convert to',
    () {
      test(
        'Celsius',
        () {
          final temperature = Temperature(
            unit: TemperatureUnit.celsius,
            value: 0.0,
          );

          expect(
            temperature.toDomainModel(),
            domain.Temperature.celsius(0.0),
          );
        },
      );

      test(
        'Fahrenheit',
        () {
          final temperature = Temperature(
            unit: TemperatureUnit.fahrenheit,
            value: 0.0,
          );

          expect(
            temperature.toDomainModel(),
            domain.Temperature.fahrenheit(0.0),
          );
        },
      );
    },
  );

  group(
    'Data temperature can convert to domain temperature',
    () {
      test(
        'Fahrenheit should return Temperature with Fahrenheit unit',
        () {
          final temperature = domain.Temperature.fahrenheit(0.0).toDataModel();

          expect(temperature.unit, TemperatureUnit.fahrenheit);
          expect(temperature.value, 0.0);
        },
      );

      test(
        'Celsius should return Temperature with Celsius unit',
        () {
          final temperature = domain.Temperature.celsius(0.0).toDataModel();

          expect(temperature.unit, TemperatureUnit.celsius);
          expect(temperature.value, 0.0);
        },
      );
    },
  );
}
