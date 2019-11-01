import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

abstract class SimpleFormField extends StatefulWidget {
  final String fieldName;
  final String title;
  final bool enabled;
  final List<SimpleValidator> validators;
  final List<SimpleFormatter> inputFormatters;
  final Function(dynamic newValue) onChange;
  final bool canSetState;

  SimpleFormField({
    Key key,
    @required this.fieldName,
    this.title,
    this.enabled,
    this.validators,
    this.inputFormatters,
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

  defaultTextInputDecoration(String title, {Widget sufix}) {
    return InputDecoration(
      labelText: title,
      suffix: sufix
    );
  }

  Widget build(BuildContext context, SimpleFormFieldState simpleForm);

  @override
  State<StatefulWidget> createState() => SimpleFormFieldState();
}

class SimpleFormFieldState extends State<SimpleFormField> {
  SimpleForm _simpleForm;
  SimpleForm get simpleForm => _simpleForm;

  dynamic _value;
  dynamic get value => _value;

  @override
  void didChangeDependencies() {
    if (simpleForm == null) {
      _simpleForm = (context.inheritFromWidgetOfExactType(SimpleForm) as SimpleForm);
      _value = simpleForm.getInitialValue(widget.fieldName);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, this);
  }

  setValue(dynamic newValue, {bool canSetState}) {
    if (newValue != value) {
      _value = newValue;

      if ((canSetState == null && widget.canSetState) || (canSetState != null && canSetState)) {
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