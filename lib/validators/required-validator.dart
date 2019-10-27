import 'package:simple_form/simple_form.dart';

class RequiredValidator extends SimpleValidator {
  String emptyError = 'Campo obrigatório';

  RequiredValidator();

  @override
  String isValid(dynamic value) {
    if (!SimpleValidator.hasValue(value)) {
      return emptyError;
    }
    return null;
  }
}