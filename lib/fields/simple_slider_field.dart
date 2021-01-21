import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';
import 'package:simple_form/patterns/simple_form_field.dart';

class SimpleSliderField extends SimpleFormField {
  final double min;
  final double max;
  final int divisions;
  final Function(dynamic newValue) onChangeStart;
  final Function(dynamic newValue) onChangeEnd;
  final Function(double value) buildLabel;

  SimpleSliderField({
    Key key,
    @required String title,
    @required String fieldName,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    Function(dynamic newValue) onChange,
    this.onChangeStart,
    this.onChangeEnd,
    this.buildLabel,
  }) : super(
    key: key, 
    fieldName: fieldName, 
    title: title,
    onChange: onChange,
    canSetState: true
  );

  @override
  Widget build(BuildContext context, SimpleFormFieldState field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.bodyText2,),
        Slider(
          key: this.key,
          value: field.value,
          onChanged: field.setValue,
          onChangeStart: onChangeStart,
          onChangeEnd: onChangeEnd,
          min: this.min,
          max: this.max,
          divisions: this.divisions,
          label: (buildLabel != null ? buildLabel(field.value) : null),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).accentColor.withAlpha(50),
        )
      ],
    );
  }
}