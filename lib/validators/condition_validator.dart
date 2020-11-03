import 'package:simple_form/simple_form.dart';

class ConditionValidator extends SimpleValidator {
  final String Function(dynamic value) validation;

  const ConditionValidator(this.validation) : super();

  @override
  String isValid(context, value) {
    return validation(value);
  }
}