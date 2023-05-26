import 'package:domain/model/model.dart';
import 'package:test/test.dart';

const _fahrenheitPerCelsius = 33.8;
const _celsiusPerFahrenheit = -17.22222222222222;

void main() {
  test(
    'String expression',
    () {
      expect(Celsius(1.555).toStringAsFixed(2), '1.55 °C');
      expect(Fahrenheit(1.555).toStringAsFixed(2), '1.55 °F');
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
            Celsius(1.0) + Celsius(1.0),
            Celsius(2.0),
          );
          expect(
            Celsius(1.0) + Fahrenheit(1.0),
            Celsius(1.0 + _celsiusPerFahrenheit),
          );

          // Fahrenheit
          expect(
            Fahrenheit(1.0) + Celsius(1.0),
            Fahrenheit(1.0 + _fahrenheitPerCelsius),
          );
          expect(
            Fahrenheit(1.0) + Fahrenheit(1.0),
            Fahrenheit(2.0),
          );
        },
      );

      test(
        'Subtraction',
        () {
          // Celsius
          expect(
            Celsius(1.0) - Celsius(1.0),
            Celsius(0.0),
          );
          expect(
            Celsius(1.0) - Fahrenheit(1.0),
            Celsius(1.0 - _celsiusPerFahrenheit),
          );

          // Fahrenheit
          expect(
            Fahrenheit(1.0) - Celsius(1.0),
            Fahrenheit(1.0 - _fahrenheitPerCelsius),
          );
          expect(
            Fahrenheit(1.0) - Fahrenheit(1.0),
            Fahrenheit(0.0),
          );
        },
      );

      test(
        'Multiblication',
        () {
          expect(Celsius(1.0) * 2, Celsius(2.0));
          expect(Fahrenheit(1.0) * 2, Fahrenheit(2.0));
        },
      );

      test(
        'Division',
        () {
          expect(Celsius(2.0) / 2, Celsius(1.0));
          expect(Fahrenheit(2.0) / 2, Fahrenheit(1.0));
        },
      );
    },
  );

  group(
    '[Convert temperature unit]',
    () {
      final celsius = Temperature.celsius(1.0);
      final farhenheit = Temperature.fahrenheit(1.0);

      test(
        'Convert to toCelsius',
        () {
          expect(
            celsius.toCelsius(),
            Temperature.celsius(1.0),
          );
          expect(
            farhenheit.toCelsius(),
            Temperature.celsius(_celsiusPerFahrenheit),
          );
        },
      );

      test(
        'Convert to fahrenheit',
        () {
          expect(
            celsius.toFahrenheit(),
            Temperature.fahrenheit(_fahrenheitPerCelsius),
          );
          expect(
            farhenheit.toFahrenheit(),
            Temperature.fahrenheit(1.0),
          );
        },
      );
    },
  );
}
