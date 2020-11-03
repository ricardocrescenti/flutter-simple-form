import 'package:simple_form/simple_form.dart';

class CompleteNameValidator extends SimpleValidator {
  const CompleteNameValidator(): super();
  
  @override
  String isValid(context, value) {
    if (SimpleValidator.hasValue(value)) {
      List<String> parts = value.split(' ');
      if (parts.length < 2) {
        return SimpleFormLocalization.of(context)[ValidatorsMessages.invalidName];
      } else {
        for(int i = 0; i < parts.length; i++) {
          if (parts[i].trim().length <= 1) {
            print(parts[i]);
            return SimpleFormLocalization.of(context)[ValidatorsMessages.invalidName];
          }
        }
      }
    }
    return null;
  }
}