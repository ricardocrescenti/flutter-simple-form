import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleCheckField extends SimpleFormField {
  SimpleCheckField({
    Key key,
    @required String fieldName,
    @required String title,
    bool enabled = true,
    List<SimpleValidator> validators,
    Function(dynamic newValue) onChange,
  }) : super(
    key: key, 
    fieldName: fieldName, 
    title: title,
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
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: field.value,
          onChanged: field.setValue,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title)
            ],
          )
        )
      ],
    );
  }
}