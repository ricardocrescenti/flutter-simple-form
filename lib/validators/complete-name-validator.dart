import 'package:simple_form/simple_form.dart';

class CompleteNameValidator extends SimpleValidator {
  String invalidError = 'Nome inválido';

  @override
  String isValid(value) {
    if (SimpleValidator.hasValue(value)) {
      List<String> parts = value.split(' ');
      if (parts.length < 2) {
        return invalidError;
      } else {
        for(int i = 0; i < parts.length; i++) {
          if (parts[i].trim().length <= 1) {
            print(parts[i]);
            return invalidError;
          }
        }
      }
    }
    return null;
  }
}