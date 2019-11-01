import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_form/simple_form.dart';

class SimpleTextField extends SimpleFormField {
  final TextInputType keyboardType;
  final InputDecoration inputDecoration;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final bool obscureText;
  
  SimpleTextField({
    Key key,
    @required String fieldName,
    @required String title,
    bool enabled = true,
    List<SimpleValidator> validators,
    List<SimpleFormatter> inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.text,
    this.inputDecoration,
    this.maxLines = 1,
    this.obscureText = false,
    Function(dynamic newValue) onChange,
  }) : super(
    key: key, 
    fieldName: fieldName, 
    title: title,
    enabled: enabled,
    validators: validators,
    inputFormatters: inputFormatters,
    onChange: onChange,
    canSetState: false);

  @override
  Widget build(BuildContext context, SimpleFormFieldState field) {
    return TextFormField(
      key: this.key,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: (inputDecoration ?? defaultTextInputDecoration(title)),
      controller: TextEditingController(text: field.value),
      inputFormatters: inputFormatters,
      textInputAction: (maxLines == 1 ? TextInputAction.next : TextInputAction.newline),
      maxLines: maxLines,
      onSaved: field.setValue,
      enabled: enabled,
      validator: (value) => performValidators(value),
    );
  }
}