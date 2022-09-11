import 'package:flutter/material.dart';

class FormLayout extends StatelessWidget {

	static EdgeInsets defaultPadding = const EdgeInsets.all(20);
	static CrossAxisAlignment defaultRowCrossAxisAlignment = CrossAxisAlignment.center;
	static MainAxisAlignment defaultColumnMainAxisAlignment = MainAxisAlignment.center;
	static EdgeInsets defaultFieldPadding = const EdgeInsets.only(left: 5, right: 5, bottom: 15);

	final EdgeInsets? padding;
	final bool scroll;
	final bool expanded;
	final Widget Function(FormLayout fl) builder;

	const FormLayout({
		Key? key,
		this.padding,
		this.scroll = false,
		this.expanded = false,
		required this.builder
	}) : super(
		key: key
	);

	rows(List<Widget> rows, { CrossAxisAlignment? crossAxisAlignment }) {
		return Column(
			crossAxisAlignment: (crossAxisAlignment ?? defaultRowCrossAxisAlignment),
			mainAxisSize: MainAxisSize.min,
			children: rows,
		);
	}
	columns(List<Widget> fields, { MainAxisAlignment? mainAxisAlignment }) {
		return Row(
			mainAxisAlignment: (mainAxisAlignment ?? defaultColumnMainAxisAlignment), 
			children: fields
		);
	}

	field(int columns, Widget input, { EdgeInsets? padding }) {
		return Flexible(
			flex: columns,
			child: Container(
				padding: (padding ?? defaultFieldPadding),
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

		EdgeInsets padding = (this.padding ?? defaultPadding);

		if (padding.left > 0 || padding.top > 0 || padding.right > 0 || padding.bottom > 0) {
			widget = Padding(
				padding: padding,
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