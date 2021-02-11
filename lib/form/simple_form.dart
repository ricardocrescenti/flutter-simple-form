import 'package:flutter/material.dart';

class SimpleForm extends InheritedWidget {
  final bool autovalidate;
  final bool trimValues;
  final Map<String, dynamic> initialValues;
  final Function(dynamic fieldName, dynamic newValue) onChange;

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

    List<String> fieldNameList = fieldName.split('.');
    dynamic valuesContainer = getValueContainer(fieldNameList);

    if (valuesContainer is List) {

      int position = int.tryParse(fieldNameList.last);
      if (position == null) {
        throw Exception('The position entered for field ${fieldNameList.join('.')} must be a valid number');
      } else if (valuesContainer.length < (position + 1)) {
        throw Exception('The position entered for the field ${fieldNameList.join('.')} must be less than the current list size');
      }
      
      return valuesContainer[position];

    }

    return valuesContainer[fieldNameList.last];
  }

  getValueContainer(List<String> fieldNameList) {
    dynamic valuesContainer = initialValues;
    for (int index = 0; index < fieldNameList.length - 1; index++) {

      if (valuesContainer is Map) {

        if (!valuesContainer.containsKey(fieldNameList[index])) {
          throw Exception('The field ${fieldNameList.join('.')} does not exists in SimpleForm');
        }
        valuesContainer = valuesContainer[fieldNameList[index]];
      
      } else if (valuesContainer is List) {

        int position = int.tryParse(fieldNameList[index]);
        if (position == null) {
          throw Exception('The position entered for field ${fieldNameList.join('.')} must be a valid number');
        } else if (valuesContainer.length < (position + 1)) {
          throw Exception('The position entered for the field ${fieldNameList.join('.')} must be less than the current list size');
        }
        valuesContainer = valuesContainer[position];

      } else {
        valuesContainer = valuesContainer[fieldNameList[index]];
      }

      if (index == fieldNameList.length - 1) {
        break;
      }
      // } else {
      //   valuesContainer = valuesContainer[fieldNameList[index]];
      // }
    }
    return valuesContainer;
  }

  performOnChange(String fieldName, dynamic newValue) {
    if (onChange != null) {
      onChange(fieldName.split('.'), newValue);
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
