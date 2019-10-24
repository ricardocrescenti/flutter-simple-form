import 'package:flutter/material.dart';

class LayoutForm extends StatelessWidget {
  final Function(LayoutForm lf) builder;

  LayoutForm({@required this.builder});

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
  Widget build(BuildContext context) {
    return builder(this);
  }
}