import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_form/simple_form.dart';

class SimpleComboBoxField<T> extends SimpleFormField {
  final Map<T, String> items;
  final InputDecoration inputDecoration;
  //final TextCapitalization textCapitalization;
  //final int maxLines;
  //final bool obscureText;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final InputDecoration decoration;
  //final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final bool autofocus;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  //final bool showCursor;
  //final bool autocorrect;
  final bool autovalidate;
  //final bool maxLengthEnforced;
  //final int minLines;
  final bool expands;
  //final int maxLength;
  final GestureTapCallback onTap;
  final Function(String value) onFieldSubmitted;
  //final double cursorWidth;
  //final Radius cursorRadius;
  //final Color cursorColor;
  //final Brightness keyboardAppearance;
  //final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  
  SimpleComboBoxField({
    Key key,
    @required String fieldName,
    @required String title,
    @required this.items,
    bool enabled = true,
    List<SimpleValidator> validators,
    //List<SimpleFormatter> inputFormatters,
    //this.textCapitalization = TextCapitalization.sentences,
    this.inputDecoration,
    //this.maxLines = 1,
    //this.obscureText = false,
    this.textAlign = TextAlign.start,
    Function(dynamic value) onChange,
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
    this.autovalidate = false,
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
      key: this.key,
      controller: TextEditingController(text: getDisplayText(field)),
      focusNode: _focusNode,
      decoration: (inputDecoration ?? defaultTextInputDecoration(title)),
      //textCapitalization: textCapitalization,
      textInputAction: TextInputAction.next, //(maxLines == 1 ? TextInputAction.next : TextInputAction.newline),
      style: this.style,
      strutStyle: this.strutStyle,
      textDirection: this.textDirection,
      textAlign: textAlign,
      autofocus: this.autofocus,
      readOnly: true,
      toolbarOptions: this.toolbarOptions,
      //showCursor: this.showCursor,
      //obscureText: obscureText,
      //autocorrect: this.autocorrect,
      autovalidate: this.autovalidate,
      //maxLengthEnforced: this.maxLengthEnforced,
      //maxLines: this.maxLines,
      //minLines: this.minLines,
      expands: this.expands,
      //maxLength: this.maxLength,
      onTap: () {
        if (this.onTap != null) {
          this.onTap();
        }
        showDropDownItems(context, field);
      },
      onFieldSubmitted: (value) {
        if (this.onFieldSubmitted != null) {
          this.onFieldSubmitted(value);
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
    return items[field.value];
  }

  showDropDownItems(BuildContext context, SimpleFormFieldState field) {
    showDialog(context: context,
      child: Builder(
        builder: (context) => SimpleDialog(
        //title: Text(title),
        children: _builItems(context, field))
      )
    );
  }

  List<Widget> _builItems(BuildContext context, SimpleFormFieldState field) {
    return this.items.keys.map((key) => FlatButton(
      onPressed: () {
        field.setValue(key);
        Navigator.pop(context, key);
      },
      child: Text(this.items[key].toString()),
    )).toList();
  }
}