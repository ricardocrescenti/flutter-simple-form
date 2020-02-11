import 'package:simple_form/simple_form.dart';

class ConditionValidator extends SimpleValidator {
  final String Function(dynamic value) validation;

  ConditionValidator(this.validation); 

  @override
  String isValid(context, value) {
    return validation(value);
  }
}