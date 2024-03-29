import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleComboBoxField<T> extends SimpleFormField {

	final Map<T, String> items;
	final String nullText;
	final InputDecoration? inputDecoration;
	//final TextCapitalization textCapitalization;
	//final int maxLines;
	//final bool obscureText;
	final TextAlign textAlign;
	final FocusNode? focusNode;
	final InputDecoration decoration;
	//final TextInputAction textInputAction;
	final TextStyle? style;
	final StrutStyle? strutStyle;
	final TextDirection? textDirection;
	final bool autofocus;
	final bool readOnly;
	final ToolbarOptions? toolbarOptions;
	//final bool showCursor;
	//final bool autocorrect;
	final AutovalidateMode autovalidateMode;
	//final bool maxLengthEnforced;
	//final int minLines;
	final bool expands;
	//final int maxLength;
	final GestureTapCallback? onTap;
	final Function(String value)? onFieldSubmitted;
	//final double cursorWidth;
	//final Radius cursorRadius;
	//final Color cursorColor;
	//final Brightness keyboardAppearance;
	//final EdgeInsets scrollPadding;
	final bool enableInteractiveSelection;
	final InputCounterWidgetBuilder? buildCounter;
	
	SimpleComboBoxField({
		Key? key,
		required String title,
		required String fieldName,
		required this.items,
		this.nullText = '',
		bool enabled = true,
		List<SimpleValidator>? validators,
		//List<SimpleFormatter> inputFormatters,
		//this.textCapitalization = TextCapitalization.sentences,
		this.inputDecoration,
		//this.maxLines = 1,
		//this.obscureText = false,
		this.textAlign = TextAlign.start,
		Function(dynamic value)? onChange,
		this.focusNode,
		this.decoration = const InputDecoration(),
		//this.textInputAction,
		this.style,
		this.strutStyle,
		this.textDirection,
		this.autofocus = false,
		this.readOnly = false,
		this.toolbarOptions,
		//this.showCursor,
		//this.autocorrect = true,
		this.autovalidateMode = AutovalidateMode.disabled,
		//this.maxLengthEnforced = true,
		//this.minLines,
		this.expands = false,
		//this.maxLength,
		this.onTap,
		this.onFieldSubmitted,
		//this.cursorWidth = 2.0,
		//this.cursorRadius,
		//this.cursorColor,
		//this.keyboardAppearance,
		//this.scrollPadding = const EdgeInsets.all(20.0),
		this.enableInteractiveSelection = true,
		this.buildCounter,
	}) : super(
		key: key, 
		fieldName: fieldName, 
		title: title,
		enabled: enabled,
		validators: validators,
		//inputFormatters: [ComboBoxFormatter(null)],
		onChange: onChange,
		canSetState: true);

	final FocusNode _focusNode = FocusNode();

	@override
	Widget build(BuildContext context, SimpleFormFieldState field) {
		return TextFormField(
			key: key,
			controller: TextEditingController(text: getDisplayText(field)),
			focusNode: _focusNode,
			decoration: (inputDecoration ?? SimpleFormField.defaultInputDecoration(title!)),
			//textCapitalization: textCapitalization,
			textInputAction: TextInputAction.next, //(maxLines == 1 ? TextInputAction.next : TextInputAction.newline),
			style: style,
			strutStyle: strutStyle,
			textDirection: textDirection,
			textAlign: textAlign,
			autofocus: autofocus,
			readOnly: true,
			toolbarOptions: toolbarOptions,
			//showCursor: this.showCursor,
			//obscureText: obscureText,
			//autocorrect: this.autocorrect,
			autovalidateMode: autovalidateMode,
			//maxLengthEnforced: this.maxLengthEnforced,
			//maxLines: this.maxLines,
			//minLines: this.minLines,
			expands: expands,
			//maxLength: this.maxLength,
			onTap: () {
				if (onTap != null) {
					onTap!();
				}
				showDropDownItems(context, field);
			},
			onFieldSubmitted: (value) {
				if (onFieldSubmitted != null) {
					onFieldSubmitted!(value);
				}
				FocusScope.of(context).nextFocus();
			},
			onChanged: (value) {
				// if (this.onSaved != null) {
				//   this.onSaved(value);
				// }
				field.setValue(value);
			},
			validator: (value) => performValidators(context, value),
			inputFormatters: inputFormatters,
			enabled: enabled,
			//cursorWidth: this.cursorWidth,
			//cursorRadius: this.cursorRadius,
			//cursorColor: this.cursorColor,
			//keyboardAppearance: this.keyboardAppearance,
			//scrollPadding: this.scrollPadding,
		);
	}

	String getDisplayText(SimpleFormFieldState field) {
		return items[field.value] ?? nullText;
	}

	showDropDownItems(BuildContext context, SimpleFormFieldState field) {
		showDialog(context: context,
			builder: (context) => SimpleDialog(
				//title: Text(title),
				children: _builItems(context, field))
		);
	}

	List<Widget> _builItems(BuildContext context, SimpleFormFieldState field) {
		return items.keys.map((key) => TextButton(
			onPressed: () {
				field.setValue(key);
				Navigator.pop(context, key);
			},
			child: Text(items[key].toString()),
		)).toList();
	}
}