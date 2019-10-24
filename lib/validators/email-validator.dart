import '../patterns/standard-validator.dart';

class EmailValidator extends StandardValidator {
  String invalidError = 'Endereço de e-mail inválido';

  @override
  String isValid(value) {
    if (StandardValidator.hasValue(value) && !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return invalidError;
    }
    return null;
  }
}