import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleCheckListField<T> extends SimpleFormField {

	final Map<T, Widget> items;
	final EdgeInsets titlePadding;
	final bool Function(T item, List itemsChecked)? isChecked;
	
	const SimpleCheckListField({
		Key? key,
		String? title,
		required String fieldName,
		required this.items,
		bool enabled = true,
		List<SimpleValidator>? validators,
		Function(dynamic newValue)? onChange,
		this.titlePadding = const EdgeInsets.only(bottom: 10),
		this.isChecked
	}) : super(
		key: key, 
		fieldName: fieldName, 
		title: title,
		enabled: enabled,
		validators: validators,
		onChange: onChange,
		canSetState: true);

	@override
	Widget build(BuildContext context, SimpleFormFieldState field) {
		
		List<Widget> items = [];

		if (title != null) {

			items.add(Row(
				children: [
					Padding(
						padding: titlePadding,
						child: Text(title!, textAlign: TextAlign.start)
					)
				]
			));

		}        
		items.addAll(this.items.map<dynamic, Widget>((key, value) => _buildItem(field, key, value)).values.toList());

		return Column(children: items);

	}

	MapEntry<dynamic, Widget> _buildItem(SimpleFormFieldState field, T item, Widget child) {
		
		assert(field.value is List);
		
		return MapEntry<dynamic, Widget>(
			item, 
			Row(
				children: <Widget>[
					Checkbox(
						key: key,
						materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
						value: (isChecked != null ? isChecked!(item, field.value as List) : (field.value as List).contains(item)),
						onChanged: (checked) => _changeItem((checked ?? false), field, item),
					),
					Flexible(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [child],
						)
					)
				],
			)
		);

	}

	_changeItem(bool checked, SimpleFormFieldState field, T item) {
		
		if (checked) {
			_removeItem(field, item);
		} else {
			_addItem(field, item);
		}

	}

	_addItem(SimpleFormFieldState field, T item) {

		(field.value as List).remove(item);
		field.setValue(field.value, alwaysSet: true);

	}

	_removeItem(SimpleFormFieldState field, T item) {

		(field.value as List).add(item);
		field.setValue(field.value, alwaysSet: true);

	}
}