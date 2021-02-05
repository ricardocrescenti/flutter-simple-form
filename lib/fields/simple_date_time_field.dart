import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_form/simple_form.dart';
import 'package:intl/intl.dart';

class SimpleDateTimeField extends SimpleFormField {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final String format;
  final InputDecoration inputDecoration;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final bool autofocus;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  final AutovalidateMode autovalidateMode;
  final bool expands;
  final GestureTapCallback onTap;
  final Function(String value) onFieldSubmitted;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;

  SimpleDateTimeField({
    Key key,
    String title,
    @required String fieldName,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    @required this.format,
    bool enabled = true,
    List<SimpleValidator> validators,
    List<SimpleFormatter> inputFormatters,
    this.inputDecoration,
    this.textAlign = TextAlign.start,
    Function(dynamic newValue) onChange,
    this.focusNode,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.autofocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.expands = false,
    this.onTap,
    this.onFieldSubmitted,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
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
    return TextFormField(
      key: this.key,
      controller: TextEditingController(text: _getDisplayValue(field.value)),
      focusNode: focusNode ?? _focusNode,
      decoration: (inputDecoration ?? defaultTextInputDecoration(title, sufix: _buildShowPickerButton(context, field))),
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      style: this.style,
      strutStyle: this.strutStyle,
      textAlign: textAlign,
      autofocus: this.autofocus,
      readOnly: this.readOnly,
      toolbarOptions: this.toolbarOptions,
      showCursor: this.showCursor,
      autovalidateMode: this.autovalidateMode,
      expands: this.expands,
      onTap: this.onTap,
      onFieldSubmitted: (value) {
        if (this.onFieldSubmitted != null) {
          this.onFieldSubmitted(value);
        }
      },
      onChanged: (value) {
        field.setValue(value);
      },
      validator: (value) => performValidators(context, value),
      inputFormatters: _inputFormatters(),
      enabled: enabled,
      cursorWidth: this.cursorWidth,
      cursorRadius: this.cursorRadius,
      cursorColor: this.cursorColor,
      keyboardAppearance: this.keyboardAppearance,
      scrollPadding: this.scrollPadding,
      onSaved: field.setValue,
    );
  }

  @override
  performValidators(BuildContext context, dynamic value) {
    try {
      List<String> parts = _getPartsOfDateValue(value);      
      if (parts[0].length > 0 || parts[1].length > 0 || parts[2].length > 0) {
        DateTime.parse('${parts[0]}-${parts[1]}-${parts[2]}T${parts[3]}:${parts[4]}:${parts[5]}');
      }
    } catch(e) {
      
    }

    return super.performValidators(context, value);
  }

  @override
  parseEditValue(dynamic newValue) {
    if (newValue is DateTime) {
      return newValue;
    }

    try {
      List<String> parts = _getPartsOfDateValue(newValue);
      return DateTime.parse('${parts[0]}-${parts[1]}-${parts[2]}T${parts[3]}:${parts[4]}:${parts[5]}');
    } catch(e) {
      return null;
    }
  }

  _getDisplayValue(dynamic value) {
    try {
      return (value != null ? DateFormat(format).format(value is DateTime ? value : DateTime.parse(value)) : '');
    } catch(error) {
      return value.toString();
    }
  }

  _inputFormatters() {
    List<TextInputFormatter> inputFormatters = [
      SimpleFormatter(this.format
        .replaceAll('d', '0')
        .replaceAll('M', '0')
        .replaceAll('y', '0')
        .replaceAll('H', '0')
        .replaceAll('m', '0')
        .replaceAll('s', '0'))
    ];
    if (this.inputFormatters != null) {
      inputFormatters.addAll(this.inputFormatters);
    }
    return inputFormatters;
  }

  _buildShowPickerButton(BuildContext context, SimpleFormFieldState field) {
    return InkWell(
      onTap: () => _showDatePicker(context, field),
      child: Icon(Icons.date_range, size: 15,),
    );
  }

  _showDatePicker(BuildContext context, SimpleFormFieldState field) {
    DateTime currentDate = DateTime.now();

    showDatePicker(
      context: context,
      firstDate: (firstDate ?? DateTime(currentDate.year - 50)),
      lastDate: (lastDate ?? DateTime(currentDate.year + 50)),
      initialDate: (initialDate ?? currentDate),
    ).then((newDate) {
      if (newDate != null) {
        field.setValue(newDate, canSetState: true);
      }
    });
  }

  List<String> _getPartsOfDateValue(String value) {
    List<String> parts = ['','','','','',''];
    if (value != null && value.length > 0) {
      for (int i = 0; i < format.length; i++) {
        String part = value[i].replaceAll('_', '');
        if (format[i] == 'y') {
          parts[0] += part;
        } else if (format[i] == 'M') {
          parts[1] += part;
        } else if (format[i] == 'd') {
          parts[2] += part;
        } else if (format[i] == 'H') {
          parts[3] += part;
        } else if (format[i] == 'm') {
          parts[4] += part;
        } else if (format[i] == 's') {
          parts[5] += part;
        }
      }
    }

    _setDefaultPartValue(parts, 0, '0001');
    _setDefaultPartValue(parts, 1, '01');
    _setDefaultPartValue(parts, 2, '01');
    _setDefaultPartValue(parts, 3, '00');
    _setDefaultPartValue(parts, 4, '00');
    _setDefaultPartValue(parts, 5, '00');

    return parts;
  }

  _setDefaultPartValue(List<String> parts, int index, String defaultValue) {
    if (parts[index] == '') {
      parts[index] = defaultValue;
    }
    parts[index] = parts[index].padLeft(defaultValue.length, '0');
  }
}