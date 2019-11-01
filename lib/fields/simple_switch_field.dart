import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleSwitchField extends SimpleFormField {
  final MainAxisAlignment mainAxisAlignment;

  SimpleSwitchField({
    Key key,
    @required String fieldName,
    @required String title,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    bool enabled = true,
    Function(dynamic newValue) onChange,
  }) : super(
    key: key, 
    fieldName: fieldName, 
    title: title,
    enabled: enabled,
    onChange: onChange,
    canSetState: true);

  @override
  Widget build(BuildContext context, SimpleFormFieldState field) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title)
            ],
          ),
        Switch(
          key: this.key,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: field.value,
          onChanged: field.setValue,
        ),
      ],
    );
  }
}