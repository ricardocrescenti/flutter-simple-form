import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:simple_form/simple_form.dart';

class RequiredValidator extends SimpleValidator {
  final bool Function(BuildContext context, dynamic value) condition;

  const RequiredValidator({
    this.condition
  }): super();

  @override
  String isValid(context, value) {
    if (condition != null && !condition(context, value)) {
      return null;
    }

    if (!SimpleValidator.hasValue(value)) {
      return SimpleFormLocalization.of(context)[ValidatorsMessages.requiredValidator];
    }
    return null;
  }
}