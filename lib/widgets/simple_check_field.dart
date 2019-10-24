import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleCheckField extends DefaultFormField {
  SimpleCheckField({
    Key key,
    @required String fieldName,
    @required String title,
    List<StandardValidator> validators,
    bool enabled = true,
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
  Widget build(BuildContext context, SimpleForm simpleForm, value, setValue) {
    return Row(
      children: <Widget>[
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value,
          onChanged: setValue,
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