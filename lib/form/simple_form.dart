import 'package:flutter/material.dart';

class SimpleForm extends InheritedWidget {
  final bool autovalidate;
  final bool trimValues;
  final Map<String, dynamic> initialValues;
  final Function(String fieldName, dynamic newValue) onChange;

  SimpleForm({
    @required GlobalKey<FormState> key,
    this.autovalidate = false,
    this.trimValues = true,
    this.initialValues,
    this.onChange,
    @required Widget child
  }) : super (
    child: _createForm(key, child)
  );

  getInitialValue(String fieldName) {
    if (initialValues == null) {
      throw Exception('Then initialValue parameter of SimpleForm has not been initialized.');  
    }
    if (!initialValues.containsKey(fieldName)) {
      throw Exception('The field $fieldName does not exists in SimpleForm');
    }

    return initialValues[fieldName];
  }

  performOnChange(String fieldName, dynamic newValue) {
    if (onChange != null) {
      onChange(fieldName, newValue);
    }
  }

  rows(List<Widget> rows) {
    return Column(children: rows);
  }
  columns(List<Widget> fields, {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center}) {
    return Row(mainAxisAlignment: mainAxisAlignment, children: fields);
  }

  field(int columns, Widget input) {
    return Flexible(
      flex: columns,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[input],
        ),
      ),
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static _createForm(GlobalKey<FormState> key, Widget child) {
    return Form(
      key: key,
      onChanged: () => key.currentState.save(),
      child: child
    );
  }
}
