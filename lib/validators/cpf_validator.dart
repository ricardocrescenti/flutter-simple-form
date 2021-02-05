import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class CPFValidator extends SimpleValidator {
  const CPFValidator(): super();

  // 
  int _calculateDigit(String cpf) {
    List<int> numbers =
    cpf.split("").map((number) => int.parse(number, radix: 10)).toList();

    int modulus = numbers.length + 1;

    List<int> multiplied = [];

    for (var i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }

    int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  String isValid(BuildContext context, dynamic value) {
	String cpf = value?.replaceAll(RegExp(r'[^\d]'), "");

    // validates only if it is filled in
    if (cpf?.trim()?.isNotEmpty ?? false) {

		// the cpf is not complete
		if (cpf.length != 11) {
			return SimpleFormLocalization.of(context)[ValidatorsMessages.cpfNotComplete];
		}

		String numbers = cpf.substring(0, 9);
		numbers += _calculateDigit(numbers).toString();
		numbers += _calculateDigit(numbers).toString();

		if (numbers.substring(numbers.length - 2) != cpf.substring(cpf.length - 2)) {
			return SimpleFormLocalization.of(context)[ValidatorsMessages.cpfInvalid];
		}

	}

	return '';
  }
}