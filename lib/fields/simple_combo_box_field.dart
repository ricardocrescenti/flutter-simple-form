import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleComboBoxField<T> extends SimpleFormField {
  final String hint;
  final Map<T, dynamic> items;
  final Widget Function(T key, dynamic value) buildMenuItem;

  SimpleComboBoxField({
    Key key,
    @required String fieldName,
    @required String title,
    this.hint,
    @required this.items,
    this.buildMenuItem,
    bool enabled = true,
    Function(dynamic value) onChange,
  }) : super(
    key: key, 
    fieldName: fieldName, 
    title: title,
    enabled: enabled,
    onChange: onChange,
    canSetState: true);
  
  @override
  Widget build(BuildContext context, SimpleFormFieldState field) {
    List<DropdownMenuItem<T>> items = builItems();

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.normal)),
          DropdownButton<T>(
            key: this.key,
            items: items,
            value: field.value,
            onChanged: field.setValue,
            hint: (hint != null ? Text(hint) : null),
            isExpanded: true,
            isDense: true,
            underline: Container(),
          )
        ]
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFBDBDBD),
            width: 0.5,
          ),
        ),
      )
    );
  }

  List<DropdownMenuItem<T>> builItems() {
    return this.items.keys.map((key) => DropdownMenuItem<T>(
      value: key,
      child: (this.items[key] != null ? (buildMenuItem != null ? buildMenuItem(key, this.items[key]) : _buildMenuItem(key, this.items[key])) : _NullValue()),
    )).toList();
  }

  Widget _buildMenuItem(T key, dynamic value) {
    return (value is Widget ? value : Text(value.toString()));
  }
}

class _NullValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}