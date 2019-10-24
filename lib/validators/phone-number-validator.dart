import '../patterns/standard-validator.dart';

class PhoneNumberValidator extends StandardValidator {
  @override
  String isValid(value) {
    if (StandardValidator.hasValue(StandardValidator.retriveOnlyNumber(value)) && !validade(value)) {
      return 'Telefone inválido';
    }
    return null;
  }

}