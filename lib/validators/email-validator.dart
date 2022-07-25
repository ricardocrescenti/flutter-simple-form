import 'package:simple_form/simple_form.dart';

class EmailValidator extends SimpleValidator {

	const EmailValidator(): super();
	
	@override
	String? isValid(context, value) {

		if (SimpleValidator.hasValue(value) && !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
			return SimpleFormLocalization.of(context)[ValidatorsMessages.invalidEmail];
		}

		return null;
	}

}