import 'package:data/data.dart';
import 'package:domain/model/temperature/temperature.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group(
    'TemperatureData can convert to',
    () {
      test(
        'Celsius',
        () {
          final temperatureData = TemperatureData()
            ..unit = TemperatureUnit.celsius
            ..value = 0.0;

          expect(
            temperatureData.toTemperature(),
            Temperature.celsius(0.0),
          );
        },
      );

      test(
        'Fahrenheit',
        () {
          final temperatureData = TemperatureData()
            ..unit = TemperatureUnit.fahrenheit
            ..value = 0.0;

          expect(
            temperatureData.toTemperature(),
            Temperature.fahrenheit(0.0),
          );
        },
      );
    },
  );
}
