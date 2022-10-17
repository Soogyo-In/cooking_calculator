import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntegerInput extends TextField {
  IntegerInput({
    super.key,
    super.decoration,
    super.maxLength,
    super.onChanged,
    super.controller,
  }) : super(
          keyboardType: const TextInputType.numberWithOptions(),
          inputFormatters: [
            TextInputFormatter.withFunction(
              (oldValue, newValue) {
                if (newValue.text.isEmpty) return newValue;
                return int.tryParse(newValue.text) == null
                    ? oldValue
                    : newValue;
              },
            ),
          ],
        );
}
