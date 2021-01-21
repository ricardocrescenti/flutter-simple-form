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
    @required String title,
    @required String fieldName,
    bool enabled = true,
    List<SimpleValidator> validators,
    List<SimpleFormatter> inputFormatters,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    @required this.format,
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
      validator: (value) => performValidators(context, value),
    );
  }

  @override
  performValidators(BuildContext context, dynamic value) {
    try {
      List<String> parts = _getPartsOfDateValue(value);      
      if (parts[0].length > 0 || parts[1].length > 0 || parts[2].length > 0) {
        DateTime.parse('${parts[0]}-${parts[1]}-${parts[2]}T${parts[3]}:${parts[4]}:${parts[5]}');
      }
    } catch(e) {
      return SimpleFormLocalization.of(context)[ValidatorsMessages.invalidDate];
    }

    return super.performValidators(context, value);
  }

  @override
  parseEditValue(dynamic newValue) {
    if (newValue is DateTime) {
      return newValue;
    }

    try {
      List<String> parts = _getPartsOfDateValue(newValue);
      return DateTime.parse('${parts[0]}-${parts[1]}-${parts[2]}T${parts[3]}:${parts[4]}:${parts[5]}');
    } catch(e) {
      return null;
    }
  }

  _getDisplayValue(dynamic value) {
    try {
      return (value != null ? DateFormat(format).format(value is DateTime ? value : DateTime.parse(value)) : '');
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

  List<String> _getPartsOfDateValue(String value) {
    List<String> parts = ["","","","00","00","00"];
    if (value != null && value.length > 0) {
      for (int i = 0; i < format.length; i++) {
        String part = value[i].replaceAll('_', '');
        if (format[i] == 'y') {
          parts[0] += part;
        } else if (format[i] == 'M') {
          parts[1] += part;
        } else if (format[i] == 'd') {
          parts[2] += part;
        }
      }
    }
    return parts;
  }
}