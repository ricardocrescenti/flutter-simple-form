import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

abstract class DefaultFormField extends StatefulWidget {
  final String fieldName;
  final String title;
  final bool enabled;
  final List<StandardValidator> validators;
  final Function(dynamic newValue) onChange;
  final bool canSetState;

  DefaultFormField({
    Key key,
    @required this.fieldName,
    this.title,
    this.enabled,
    this.validators,
    this.onChange,
    @required this.canSetState
  }) : super(key: key);

  performValidators(dynamic value) {
    String error;
    if (validators != null) {
      for(int i = 0; i < validators.length; i++) {
        error = validators[i].isValid(value);
        if (error != null) {
          break;
        }
      }
    }
    return error;
  }

  defaultTextInputDecoration(String title) {
    return InputDecoration(
      labelText: title,
    );
  }

  Widget build(BuildContext context, SimpleForm simpleForm, dynamic value, Function(dynamic newValue) setValue);

  @override
  State<StatefulWidget> createState() => _DefaultFormField();
}

class _DefaultFormField extends State<DefaultFormField> {
  SimpleForm simpleForm;
  dynamic value;

  @override
  void didChangeDependencies() {
    if (simpleForm == null) {
      simpleForm = (context.inheritFromWidgetOfExactType(SimpleForm) as SimpleForm);
      value = simpleForm.getInitialValue(widget.fieldName);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, simpleForm, value, setValue);
  }

  setValue(dynamic newValue) {
    if (newValue != value) {
      value = newValue;

      if (widget.canSetState) {
        setState(() {});
      }

      performOnChange(newValue);
    }
  }

  performOnChange(dynamic newValue) {
    if (widget.onChange != null && newValue != value) {
      widget.onChange(newValue);
    }
    simpleForm.performOnChange(widget.fieldName, newValue);
  }
}