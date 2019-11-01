import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_form/simple_form.dart';
import 'package:intl/intl.dart';

class SimpleDateField extends SimpleFormField {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final String format;
  final InputDecoration inputDecoration;

  SimpleDateField({
    Key key,
    @required String fieldName,
    @required String title,
    bool enabled = true,
    List<SimpleValidator> validators,
    List<SimpleFormatter> inputFormatters,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.format,
    this.inputDecoration,
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
      keyboardType: TextInputType.datetime,
      decoration: (inputDecoration ?? defaultTextInputDecoration(title, sufix: _buildShowPickerButton(context, field))),
      controller: TextEditingController(text: _getDisplayValue(field.value)),
      inputFormatters: _inputFormatters(),
      textInputAction: TextInputAction.next,
      onSaved: field.setValue,
      enabled: enabled,
      validator: (value) => performValidators(value),
    );
  }

  _getDisplayValue(dynamic value) {
    try {
      return (value != null ? DateFormat(format).format(value) : '');
    } catch(error) {
      return value.toString();
    }    
  }

  _inputFormatters() {
    List<TextInputFormatter> inputFormatters = [
      SimpleFormatter(this.format.replaceAll('d', '0').replaceAll('M', '0').replaceAll('y', '0'))
    ];
    if (this.inputFormatters != null) {
      inputFormatters.addAll(this.inputFormatters);
    }
    return inputFormatters;
  }

  _buildShowPickerButton(BuildContext context, SimpleFormFieldState field) {
    return InkWell(
      onTap: () => _showDatePicker(context, field),
      child: Icon(Icons.date_range, size: 15,),
    );
  }

  _showDatePicker(BuildContext context, SimpleFormFieldState field) {
    DateTime currentDate = DateTime.now();

    showDatePicker(
      context: context,
      firstDate: (firstDate ?? DateTime(currentDate.year - 50)),
      lastDate: (lastDate ?? DateTime(currentDate.year + 50)),
      initialDate: (initialDate ?? currentDate),
    ).then((newDate) {
      if (newDate != null) {
        field.setValue(newDate, canSetState: true);
      }
    });
  }
}