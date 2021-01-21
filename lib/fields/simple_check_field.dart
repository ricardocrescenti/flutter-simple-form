import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleCheckField extends SimpleFormField {
  final VisualDensity visualDensity;

  SimpleCheckField({
    Key key,
    @required String fieldName,
    @required String title,
    bool enabled = true,
    List<SimpleValidator> validators,
    Function(dynamic newValue) onChange,
    this.visualDensity = VisualDensity.compact
  }) : super(
    key: key, 
    title: title,
    fieldName: fieldName, 
    enabled: enabled,
    validators: validators,
    onChange: onChange,
    canSetState: true);

  @override
  Widget build(BuildContext context, SimpleFormFieldState field) {
    return Row(
      children: <Widget>[
        Checkbox(
          key: this.key,
          value: field.value,
          onChanged: field.setValue,
          visualDensity: visualDensity,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title)
            ],
          )
        ),
      ],
    );
  }
}