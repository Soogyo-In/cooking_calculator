import 'package:cooking_calulator/model/temperature/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

const _fahrenheitPerCelsius = 33.8;
const _celsiusPerFahrenheit = -17.22222222222222;

void main() {
  test(
    'Get symbol of temperature unit',
    () {
      expect(Celsius.symbol, '°C');
      expect(Fahrenheit.symbol, '°F');
    },
  );

  test(
    'String expression',
    () {
      expect(const Celsius(1.555).toStringAsFixed(2), '1.55 °C');
      expect(const Fahrenheit(1.555).toStringAsFixed(2), '1.55 °F');
    },
  );

  group(
    '[Arithmetic operation]',
    () {
      test(
        'Addition',
        () {
          // Celsius
          expect(
            const Celsius(1.0) + const Celsius(1.0),
            const Celsius(2.0),
          );
          expect(
            const Celsius(1.0) + const Fahrenheit(1.0),
            const Celsius(1.0 + _celsiusPerFahrenheit),
          );

          // Fahrenheit
          expect(
            const Fahrenheit(1.0) + const Celsius(1.0),
            const Fahrenheit(1.0 + _fahrenheitPerCelsius),
          );
          expect(
            const Fahrenheit(1.0) + const Fahrenheit(1.0),
            const Fahrenheit(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          // Celsius
          expect(
            const Celsius(1.0) - const Celsius(1.0),
            const Celsius(0.0),
          );
          expect(
            const Celsius(1.0) - const Fahrenheit(1.0),
            const Celsius(1.0 - _celsiusPerFahrenheit),
          );

          // Fahrenheit
          expect(
            const Fahrenheit(1.0) - const Celsius(1.0),
            const Fahrenheit(1.0 - _fahrenheitPerCelsius),
          );
          expect(
            const Fahrenheit(1.0) - const Fahrenheit(1.0),
            const Fahrenheit(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(const Celsius(1.0) * 2, const Celsius(2.0));
          expect(const Fahrenheit(1.0) * 2, const Fahrenheit(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(const Celsius(2.0) / 2, const Celsius(1.0));
          expect(const Fahrenheit(2.0) / 2, const Fahrenheit(1.0));
        },
      );
    },
  );

  group(
    '[Convert temperature unit]',
    () {
      const celsius = Temperature.celsius(1.0);
      const farhenheit = Temperature.fahrenheit(1.0);

      test(
        'Convert to cubic centimeter',
        () {
          expect(
            celsius.toCelsius(),
            const Temperature.celsius(1.0),
          );
          expect(
            farhenheit.toCelsius(),
            const Temperature.celsius(_celsiusPerFahrenheit),
          );
        },
      );

      test(
        'Convert to milliliter',
        () {
          expect(
            celsius.toFahrenheit(),
            const Temperature.fahrenheit(_fahrenheitPerCelsius),
          );
          expect(
            farhenheit.toFahrenheit(),
            const Temperature.fahrenheit(1.0),
          );
        },
      );
    },
  );
}
