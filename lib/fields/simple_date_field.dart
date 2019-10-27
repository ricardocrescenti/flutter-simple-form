import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleDateField extends SimpleFormField {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
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
    canSetState: true);
    
  @override
  Widget build(BuildContext context, SimpleForm simpleForm, value, setValue) {
    return TextFormField(
      key: this.key,
      keyboardType: TextInputType.datetime,
      decoration: (inputDecoration ?? defaultTextInputDecoration(title, sufix: buildSelectDateButton(context, setValue))),
      controller: TextEditingController(text: value.toString()),
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.next,
      onSaved: setValue,
      enabled: enabled,
      validator: (value) => performValidators(value),
    );
  }

  buildSelectDateButton(BuildContext context, Function(dynamic newValue) setValue) {
    return IconButton(
      icon: Icon(Icons.date_range),
      onPressed: () => openSelectDateDialog(context, setValue),
    );
  }

  openSelectDateDialog(BuildContext context, Function(dynamic newValue) setValue) {
    DateTime currentDate = DateTime.now();

    showDatePicker(
      context: context,
      firstDate: (firstDate ?? DateTime(currentDate.year - 50)),
      lastDate: (lastDate ?? DateTime(currentDate.year + 50)),
      initialDate: (initialDate ?? currentDate),
    ).then((newDate) {
      if (newDate != null) {
        setValue(newDate);
      }
    });
  }
}