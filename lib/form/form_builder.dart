import 'package:flutter/material.dart';

class FormFieldBase {}

class FormValue extends FormFieldBase {

	dynamic value;
	Widget Function(BuildContext context, String fieldName) build;

	FormValue(
		this.value,
		this.build
	);

}

class FormList extends FormFieldBase {

	List<FormFieldBase> items;

	FormList(
		this.items
	);

}

class FormGroup extends FormFieldBase {

	Map<String, FormFieldBase> fields;

	FormGroup(
		this.fields
	);

}

class FormBuilderController<T> {

	final T Function(BuildContext context) initialData;
	final Map<String, FormFieldBase> Function(BuildContext context, T data)? fieldsMapping;

	late Map<String, dynamic> values;
	late Map<String, FormValue> fields;

	FormBuilderController({
		required this.initialData,
		this.fieldsMapping,
	});

	initializeStructure(BuildContext context) {

		if (fieldsMapping != null) {
			return;
		}

		T data = initialData(context);
		values = _createMap(fieldsMapping!(context, data));

	}

	Map<String, dynamic> _createMap(Map<String, FormFieldBase> fieldsMapping) {

		Map<String, dynamic> map = {};
		
		fieldsMapping.forEach((key, value) {
			
			if (value is FormValue) {
				map[key] = value.value;
			} else if (value is FormGroup) {
				map[key] = _createMap(value.fields);
			} else if (value is FormList) {
				map[key] = _createList(value.items);
			}

		});

		return map;

	}

	List _createList(List<FormFieldBase> items) {

		List list = [];

		for (var item in items) {

			if (item is FormValue) {
				list.add(item.value);
			} else if (item is FormGroup) {
				list.add(_createMap(item.fields));
			} else if (item is FormList) {
				list.add(_createList(item.items));
			}
		}

		return list;

	}
}

class FormBuilder<T> extends StatefulWidget {

	final FormBuilderController controller;
	final Widget Function(BuildContext context, FormBuilderController controller, Widget Function(BuildContext context, String fieldName) buildField) buildForm;

	const FormBuilder({
		Key? key,
		required this.controller,
		required this.buildForm,
	}) : super(
		key: key
	);

	@override
	State<StatefulWidget> createState() => _FormBuilderState();

}

class _FormBuilderState extends State<FormBuilder> {

	late FormBuilderController controller;

	@override
	void initState() {
		super.initState();
		controller = widget.controller;
		controller.initializeStructure(context);
	}

	@override
	Widget build(BuildContext context) {
		return widget.buildForm(context, controller, buildField);
	}

	Widget buildField(BuildContext context, String fieldName) {
		return controller.fields[fieldName]!.build(context, fieldName);
	}

}

class TesteController {

	late FormBuilderController formController;

	initialize(BuildContext context) {

		formController = FormBuilderController(
			initialData: (context) => ModalRoute.of(context)!.settings.arguments,
			fieldsMapping: (context, data) => {
				'entity': FormGroup({
					'name': FormValue('', (context, fieldName) => Container()),
					'displayName': FormValue('', (context, fieldName) => Container()),
					'email': FormValue('', (context, fieldName) => Container()),
					'documents': FormList([
						FormGroup({
							'type': FormValue('', (context, fieldName) => Container()),
							'document': FormValue('', (context, fieldName) => Container()),
						}),
					]),
					'phones': FormList([
						FormGroup({
							'type': FormValue('', (context, fieldName) => Container()),
							'phoneNumber': FormValue('', (context, fieldName) => Container()),
						})
					]),
					'birthDate': FormValue('', (context, fieldName) => Container()),
					'gender': FormValue('', (context, fieldName) => Container()),
				}),
			},
		);
	}

}

class TestePage extends StatelessWidget {

	final TesteController controller = TesteController();

	TestePage({ Key? key }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return FormBuilder(
			controller: controller.formController,
			buildForm: (context, formController, buildField) {

				return Column(
					children: formController.fields.keys.map<Widget>((fieldName) => buildField(context, fieldName)).toList()
				);

			}
		);
	}

}