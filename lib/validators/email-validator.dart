import 'package:simple_form/simple_form.dart';

class EmailValidator extends SimpleValidator {
  String invalidError = 'Endereço de e-mail inválido';

  @override
  String isValid(value) {
    if (SimpleValidator.hasValue(value) && !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return invalidError;
    }
    return null;
  }
}