import 'package:simple_form/simple_form.dart';

class PhoneNumberValidator extends SimpleValidator {
  const PhoneNumberValidator(): super();
  
  @override
  String isValid(context, value) {
    if (SimpleValidator.hasValue(SimpleValidator.retriveOnlyNumber(value)) && !validade(value)) {
      return SimpleFormLocalization.of(context)[ValidatorsMessages.invalidPhone];
    }
    return null;
  }

}