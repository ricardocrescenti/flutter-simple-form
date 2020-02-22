import 'package:simple_form/simple_form.dart';

class MinimumSizeValidator extends SimpleValidator {
  final int minimumSize;
  MinimumSizeValidator(this.minimumSize);

  @override
  String isValid(context, value) {
    if (value == null || value.toString().length < minimumSize) {
      return SimpleFormLocalization.of(context)[ValidatorsMessages.minimumSize].replaceAll('[min_size]', minimumSize.toString());
    }
    return null;
  }
}