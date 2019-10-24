import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_form/simple_form.dart';

class SimpleTextField extends DefaultFormField {
  final TextInputType keyboardType;
  final InputDecoration inputDecoration;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines;
  final bool obscureText;
  
  SimpleTextField({
    Key key,
    @required String fieldName,
    @required String title,
    this.keyboardType = TextInputType.text,
    this.inputDecoration,
    this.inputFormatters,
    List<StandardValidator> validators,
    this.maxLines = 1,
    this.obscureText = false,
    bool enabled = true,
    Function(dynamic newValue) onChange,
  }) : super(
    key: key, 
    fieldName: fieldName, 
    title: title,
    enabled: enabled,
    validators: validators,
    onChange: onChange,
    canSetState: false);

  @override
  Widget build(BuildContext context, SimpleForm simpleForm, value, setValue) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: (inputDecoration ?? defaultTextInputDecoration(title)),
      controller: TextEditingController(text: value),
      inputFormatters: inputFormatters,
      textInputAction: (maxLines == 1 ? TextInputAction.next : TextInputAction.newline),
      maxLines: maxLines,
      onSaved: setValue,
      enabled: enabled,
      validator: (value) => performValidators(value)
    );
  }
}