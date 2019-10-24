import '../patterns/standard-validator.dart';

class RequiredValidator extends StandardValidator {
  String emptyError = 'Campo obrigatório';

  RequiredValidator();

  @override
  String isValid(dynamic value) {
    if (!StandardValidator.hasValue(value)) {
      return emptyError;
    }
    return null;
  }
}