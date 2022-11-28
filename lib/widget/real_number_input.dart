import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RealNumberInput extends TextField {
  RealNumberInput({
    super.key,
    super.decoration,
    super.maxLength,
    super.onChanged,
    super.controller,
  }) : super(
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: false,
          ),
          inputFormatters: [
            TextInputFormatter.withFunction(
              (oldValue, newValue) {
                if (newValue.text.isEmpty) return newValue;
                return double.tryParse(newValue.text) == null
                    ? oldValue
                    : newValue;
              },
            ),
          ],
        );
}
