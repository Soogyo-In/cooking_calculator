extension DoubleExtension on double {
  double roundAt(int fractionDigits) {
    var result = this;
    for (var i = 0; i < fractionDigits - 1; i++) {
      result *= 10.0;
    }

    // fix floating point error;
    result *= 10.0;
    result = result.roundToDouble();
    result /= 10.0;

    result = result.roundToDouble();

    for (var i = 0; i < fractionDigits - 1; i++) {
      result /= 10.0;
    }

    return result;
  }
}
