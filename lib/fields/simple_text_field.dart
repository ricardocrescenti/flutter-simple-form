import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_form/simple_form.dart';

class SimpleTextField extends SimpleFormField {

	static EdgeInsets defaultScrollPadding = const EdgeInsets.all(20.0);
	static EdgeInsets defaultOutlinePadding = const EdgeInsets.only(bottom: 10);

	final TextInputType? keyboardType;
	final InputDecoration? inputDecoration;
	final EdgeInsets? padding;
	final TextCapitalization textCapitalization;
	final int maxLines;
	final bool obscureText;
	final TextAlign textAlign;
	final FocusNode? focusNode;
	final TextInputAction? textInputAction;
	final TextStyle? style;
	final StrutStyle? strutStyle;
	final TextDirection? textDirection;
	final bool autofocus;
	final bool readOnly;
	final ToolbarOptions? toolbarOptions;
	final bool? showCursor;
	final bool autocorrect;
	final AutovalidateMode autovalidateMode;
	final MaxLengthEnforcement maxLengthEnforcement;
	final int minLines;
	final bool expands;
	final int? maxLength;
	final GestureTapCallback? onTap;
	final Function(String value)? onFieldSubmitted;
	final double cursorWidth;
	final Radius? cursorRadius;
	final Color? cursorColor;
	final Brightness? keyboardAppearance;
	final EdgeInsets? scrollPadding;
	final bool enableInteractiveSelection;
	final InputCounterWidgetBuilder? buildCounter;
	
	SimpleTextField({
		Key? key,
		required String title,
		required String fieldName,
		bool enabled = true,
		List<SimpleValidator>? validators,
		List<SimpleFormatter>? inputFormatters,
		this.textCapitalization = TextCapitalization.sentences,
		this.keyboardType,
		this.inputDecoration,
		this.padding = EdgeInsets.zero,
		this.maxLines = 1,
		this.minLines = 1,
		this.obscureText = false,
		this.textAlign = TextAlign.start,
		Function(dynamic value)? onChange,
		this.focusNode,
		this.textInputAction,
		this.style,
		this.strutStyle,
		this.textDirection,
		this.autofocus = false,
		this.readOnly = false,
		this.toolbarOptions,
		this.showCursor,
		this.autocorrect = true,
		this.autovalidateMode = AutovalidateMode.disabled,
		this.maxLengthEnforcement = MaxLengthEnforcement.truncateAfterCompositionEnds,
		this.expands = false,
		this.maxLength,
		this.onTap,
		this.onFieldSubmitted,
		this.cursorWidth = 2.0,
		this.cursorRadius,
		this.cursorColor,
		this.keyboardAppearance,
		this.scrollPadding,
		this.enableInteractiveSelection = true,
		this.buildCounter,
	}) : super(
		key: key, 
		fieldName: fieldName, 
		title: title,
		enabled: enabled,
		validators: validators,
		inputFormatters: inputFormatters,
		onChange: onChange,
		canSetState: false);

	final FocusNode _focusNode = FocusNode();

	@override
	Widget build(BuildContext context, SimpleFormFieldState field) {

		InputDecoration decoration = (inputDecoration ?? SimpleFormField.defaultInputDecoration(title!));
		EdgeInsets padding = this.padding ?? (decoration.border is OutlineInputBorder ? defaultOutlinePadding : EdgeInsets.zero);

		return Padding(
			padding: padding,
			child: TextFormField(
			key: key,
			controller: TextEditingController(text: field.value?.toString()),
			focusNode: focusNode ?? _focusNode,
			decoration: decoration,
			keyboardType: keyboardType ?? (maxLines > 1 ?  TextInputType.multiline : TextInputType.text),
			textCapitalization: textCapitalization,
			textInputAction: (maxLines == 1 ? TextInputAction.next : TextInputAction.newline),
			style: style,
			strutStyle: strutStyle,
			textDirection: textDirection,
			textAlign: textAlign,
			autofocus: autofocus,
			readOnly: readOnly,
			toolbarOptions: toolbarOptions,
			showCursor: showCursor,
			obscureText: obscureText,
			autocorrect: autocorrect,
			autovalidateMode: autovalidateMode,
			maxLengthEnforcement: maxLengthEnforcement,
			maxLines: maxLines,
			minLines: minLines,
			expands: expands,
			maxLength: maxLength,
			onTap: onTap,
			onFieldSubmitted: (value) {
				if (onFieldSubmitted != null) {
					onFieldSubmitted!(value);
				}
				//FocusScope.of(context).nextFocus();
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
			cursorWidth: cursorWidth,
			cursorRadius: cursorRadius,
			cursorColor: cursorColor,
			keyboardAppearance: keyboardAppearance,
			scrollPadding: scrollPadding ?? defaultScrollPadding,
		));

	}
}