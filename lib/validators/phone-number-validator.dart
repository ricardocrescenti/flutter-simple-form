import 'package:simple_form/simple_form.dart';

class PhoneNumberValidator extends SimpleValidator {
  @override
  String isValid(value) {
    if (SimpleValidator.hasValue(SimpleValidator.retriveOnlyNumber(value)) && !validade(value)) {
      return 'Telefone inválido';
    }
    return null;
  }

}