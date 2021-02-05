import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class CNPJValidator extends SimpleValidator {
  const CNPJValidator(): super();

  // 
  static int _calculateDigit(String cnpj) {
    int index = 2;

    List<int> reverse =
        cnpj.split("").map((s) => int.parse(s)).toList().reversed.toList();

    int sum = 0;

    reverse.forEach((number) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    });

    int mod = sum % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  String isValid(BuildContext context, dynamic value) {
    String cnpj = value?.replaceAll(RegExp(r'[^\d]'), "");

	// validates only if it is filled in
    if (cnpj?.trim()?.isNotEmpty ?? false) {

		// the cnpj is not complete
		if (cnpj.length != 14) {
			return SimpleFormLocalization.of(context)[ValidatorsMessages.cnpjNotComplete];
		}

		String numbers = cnpj.substring(0, 12);
		numbers += _calculateDigit(numbers).toString();
		numbers += _calculateDigit(numbers).toString();

		if (numbers.substring(numbers.length - 2) != cnpj.substring(cnpj.length - 2)) {
			return SimpleFormLocalization.of(context)[ValidatorsMessages.cnpjInvalid];
		}

	}

	return '';
  }
}