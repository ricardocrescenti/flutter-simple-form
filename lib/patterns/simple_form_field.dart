import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

abstract class SimpleFormField extends StatefulWidget {

	final String fieldName;
	final String? title;
	final bool enabled;
	final List<SimpleValidator>? validators;
	final List<SimpleFormatter>? inputFormatters;
	final ValueChanged<dynamic>? onChange;
	final bool canSetState;

	const SimpleFormField({
		Key? key,
		required this.fieldName,
		this.title,
		this.enabled = true,
		this.validators,
		this.inputFormatters,
		this.onChange,
		required this.canSetState
	}) : super(key: key);

	String? performValidators(BuildContext context, dynamic value) {

		String? error;

		if (validators != null) {

			for(int i = 0; i < validators!.length; i++) {

				error = validators![i].isValid(context, value);
				if (error != null && error.isNotEmpty) {
					break;
				}

			}

		}
	
		return (error == null || error.isEmpty ? null : error);
	
	}

	InputDecoration defaultTextInputDecoration(String title, { Widget? sufix }) {
	
		return InputDecoration(
			labelText: title,
			suffix: sufix
		);
	
	}

	dynamic parseEditValue(dynamic newValue) {
		return newValue;
	}

	Widget build(BuildContext context, SimpleFormFieldState simpleForm);

	@override
	State<StatefulWidget> createState() => SimpleFormFieldState();

}

class SimpleFormFieldState extends State<SimpleFormField> {

	SimpleForm? _simpleForm;
	SimpleForm get simpleForm => _simpleForm!;

	//dynamic _value;
	dynamic get value => simpleForm.getInitialValue(widget.fieldName);

	@override
	void didChangeDependencies() {

		_simpleForm ??= context.dependOnInheritedWidgetOfExactType<SimpleForm>();
		super.didChangeDependencies();

	}

	@override
	Widget build(BuildContext context) {
		return widget.build(context, this);
	}

	void setValue(dynamic newValue, { bool? canSetState, bool alwaysSet = false}) {

		if (simpleForm.trimValues && newValue != null && newValue is String) {
			newValue = newValue.toString().trim();
		}

		dynamic parsedEditValue = widget.parseEditValue(newValue);
		
		if (parsedEditValue != value || alwaysSet) {
			//_value = parsedEditValue;

			if ((canSetState == null && widget.canSetState) || (canSetState != null && canSetState)) {
				setState(() {});
			}

			performOnChange(parsedEditValue);
		}

	}

	void performOnChange(dynamic newValue) {

		if (widget.onChange != null) {
			widget.onChange!(newValue);
		}
		simpleForm.performOnChange(widget.fieldName, newValue);

	}

}