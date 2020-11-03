import 'package:flutter/material.dart';

abstract class SimpleValidator {
  const SimpleValidator();

  String isValid(BuildContext context, dynamic value);

  bool validade(String value) {
    return true;
  }

  static bool hasValue(dynamic value) {
    return !(value == null || value == '' || value == 0);
  }

  static String retriveOnlyNumber(String value) {
    if (hasValue(value)) {
      String numbers = '';
      for(int i = 0; i < value.length; i++) {
        if (int.tryParse(value[i]) != null) {
          numbers += value[i];
        }
      }
      return numbers;
    }
    return null;
  }

}