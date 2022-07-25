import 'package:flutter/material.dart';

class FormLayout extends StatelessWidget {

	final EdgeInsets? padding;
	final bool scroll;
	final bool expanded;
	final Widget Function(FormLayout fl) builder;

	const FormLayout({
		Key? key,
		this.padding = const EdgeInsets.all(20),
		this.scroll = false,
		this.expanded = false,
		required this.builder
	}) : super(
		key: key
	);

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
				padding: const EdgeInsets.only(left: 5, right: 5, bottom: 15),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[input],
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		Widget widget = builder(this);

		if (padding != null && (padding!.left > 0 || padding!.top > 0 || padding!.right > 0 || padding!.bottom > 0)) {
			widget = Padding(
				padding: padding!,
				child: widget
			);
		}

		if (scroll) {
			widget = SingleChildScrollView(child: widget);
		}

		if (expanded) {
			widget = Expanded(child: widget);
		}

		return widget;
	}
}