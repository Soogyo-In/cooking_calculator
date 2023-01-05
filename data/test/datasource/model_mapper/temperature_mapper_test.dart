import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Temperature can convert to TemperatureData',
    () {
      test(
        'Fahrenheit should return TemperatureData with Fahrenheit unit',
        () {
          final temperatureData =
              Temperature.fahrenheit(0.0).toTemperatureData();

          expect(temperatureData.unit, TemperatureUnit.fahrenheit);
          expect(temperatureData.value, 0.0);
        },
      );

      test(
        'Celsius should return TemperatureData with Celsius unit',
        () {
          final temperatureData = Temperature.celsius(0.0).toTemperatureData();

          expect(temperatureData.unit, TemperatureUnit.celsius);
          expect(temperatureData.value, 0.0);
        },
      );
    },
  );
}
