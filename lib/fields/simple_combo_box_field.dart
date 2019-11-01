import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleComboBoxField<T> extends SimpleFormField {
  final String hint;
  final List<dynamic> items;
  final Widget Function(T item) buildMenuItem;

  SimpleComboBoxField({
    Key key,
    @required String fieldName,
    @required String title,
    this.hint,
    this.items,
    this.buildMenuItem,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        DropdownButton<T>(
          key: this.key,
          items: builItems(),
          value: field.value,
          onChanged: field.setValue,
          hint: (hint != null ? Text(hint) : null),
          isExpanded: true,
        )
      ]
    );
  }

  List<DropdownMenuItem<T>> builItems() {
    return this.items.map((item) => DropdownMenuItem<T>(
      value: item,
      child: (buildMenuItem != null ? buildMenuItem(item) : _buildMenuItem(item)),
    )).toList();
  }

  Widget _buildMenuItem(T item) {
    return Text(item.toString() ?? "");
  }
}