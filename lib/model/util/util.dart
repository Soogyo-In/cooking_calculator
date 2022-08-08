extension DoubleExtension on double {
  String toZeroBoundedStringAsFixed(int fractionDigits) {
    var result = double.parse(toStringAsFixed(fractionDigits + 1));

    for (var i = 0; i < fractionDigits; i++) {
      result *= 10.0;
    }

    result = result.roundToDouble();

    for (var i = 0; i < fractionDigits; i++) {
      result /= 10.0;
    }

    if (result == 0.0) {
      result = 1.0;
      for (var i = 0; i < fractionDigits; i++) {
        result /= 10.0;
      }
    }

    return result.toStringAsFixed(fractionDigits);
  }
}
