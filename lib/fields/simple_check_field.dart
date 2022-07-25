import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';

class SimpleCheckField extends SimpleFormField {

	/// The cursor for a mouse pointer when it enters or is hovering over the
	/// widget.
	///
	/// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
	/// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
	///
	///  * [MaterialState.selected].
	///  * [MaterialState.hovered].
	///  * [MaterialState.focused].
	///  * [MaterialState.disabled].
	///
	/// When value is null and [tristate] is true, [MaterialState.selected] is
	/// included as a state.
	///
	/// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
	final MouseCursor? mouseCursor;

	/// The color to use when this checkbox is checked.
	///
	/// Defaults to [ThemeData.toggleableActiveColor].
	final Color? activeColor;

	/// The color to use for the check icon when this checkbox is checked.
	///
	/// Defaults to Color(0xFFFFFFFF)
	final Color? checkColor;

	/// If true the checkbox's `value` can be true, false, or null.
	///
	/// Checkbox displays a dash when its value is null.
	///
	/// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
	/// callback will be applied to true if the current value is false, to null if
	/// value is true, and to false if value is null (i.e. it cycles through false
	/// => true => null => false when tapped).
	///
	/// If tristate is false (the default), `value` must not be null.
	final bool tristate;

	/// Configures the minimum size of the tap target.
	///
	/// Defaults to [ThemeData.materialTapTargetSize].
	///
	/// See also:
	///
	///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
	final MaterialTapTargetSize materialTapTargetSize;

	/// Defines how compact the checkbox's layout will be.
	///
	/// {@macro flutter.material.themedata.visualDensity}
	///
	/// See also:
	///
	///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
	///    widgets within a [Theme].
	final VisualDensity visualDensity;

	/// The color for the checkbox's [Material] when it has the input focus.
	final Color? focusColor;

	/// The color for the checkbox's [Material] when a pointer is hovering over it.
	final Color? hoverColor;

	/// {@macro flutter.widgets.Focus.focusNode}
	final FocusNode? focusNode;

	/// {@macro flutter.widgets.Focus.autofocus}
	final bool autofocus;

	const SimpleCheckField({
		Key? key,
		required String fieldName,
		required String title,
		bool enabled = true,
		List<SimpleValidator>? validators,
		Function(dynamic newValue)? onChange,
		this.mouseCursor,
		this.activeColor,
		this.checkColor,
		this.tristate = false,
		this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
		this.visualDensity = VisualDensity.compact,
		this.focusColor,
		this.hoverColor,
		this.focusNode,
		this.autofocus = false,
	}) : super(
		key: key, 
		title: title,
		fieldName: fieldName, 
		enabled: enabled,
		validators: validators,
		onChange: onChange,
		canSetState: true);

	@override
	Widget build(BuildContext context, SimpleFormFieldState field) {
		return Row(
			children: <Widget>[
				Checkbox(
					key: key,
					value: field.value,
					onChanged: field.setValue,
					mouseCursor: mouseCursor,
					activeColor: activeColor,
					checkColor: checkColor,
					tristate: tristate,
					materialTapTargetSize: materialTapTargetSize,
					visualDensity: visualDensity,
					focusColor: focusColor,
					hoverColor: hoverColor,
					focusNode: focusNode,
					autofocus: autofocus,
				),
				Expanded(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(title!)
						],
					)
				),
			],
		);
	}
}