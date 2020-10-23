//import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
//import 'dart:math';

class SimpleFormatter extends TextInputFormatter {
  static String _formatDigits = '*A0@';

  final String format;

  String _displayFormat;
  int _startPosition = 0;

  TextEditingValue _lastNewValue;

  SimpleFormatter(this.format) {
    /// get display format to show in input text
    _displayFormat = displayFormat(format, emptySpace: '_');

    /// get start position in input text
    for (int i = 0; i < format.length; i++) {
      if (_formatDigits.contains(format[i])) {
        _startPosition = i;
        break;
      }
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue == _lastNewValue) {
      return oldValue;
    }
    
    String oldText = oldValue.text.toString();
    String newText = newValue.text.toString();
    String resultText = (oldText.length == 0 ? _displayFormat : oldText);
    int selectionStart = (newValue.selection.start-1);

    if (newText.length == 0) {
      resultText = _displayFormat;
      selectionStart = _startPosition;
    } else {
      if (oldText.length == 0) {
        newText = _displayFormat;
      }
      if (newText.length > oldText.length) {
        
        if (selectionStart >= format.length) {
          return oldValue;
        }

        String digit = newValue.text[selectionStart];
        int positionInsertDigit = nextDigitablePosition(format, selectionStart);
        if (!validDigit(digit, format[positionInsertDigit])) {
          return oldValue;
        }
        resultText = resultText.replaceRange(positionInsertDigit, (positionInsertDigit + 1), digit);
        positionInsertDigit++;
        selectionStart = nextDigitablePosition(format, positionInsertDigit);
      
      } else if (newText.length < oldText.length) {
        
        String digitInsert = (_formatDigits.contains(format[selectionStart+1]) ? '_' : format[selectionStart+1]);
        resultText = resultText.replaceRange(selectionStart+1, (selectionStart + 2), digitInsert);
        
        selectionStart++;
        while (selectionStart > _startPosition && !_formatDigits.contains(format[selectionStart-1])) {
          selectionStart--;
        }
      }
    }

    if (oldValue.text.isEmpty) {
      oldValue = oldValue.copyWith(text: _displayFormat);
    }

    _lastNewValue = newValue;
    return newValue.copyWith(
      text: resultText, selection: TextSelection(baseOffset: selectionStart));
  }

  static String formatText(String value, String format, {bool displayFormatIfEmpty = false, String emptySpace = ' '}) {
    if (value == null || value.isEmpty) {
      return (displayFormatIfEmpty
          ? displayFormat(format, emptySpace: emptySpace)
          : '');
    }
    int indexValueCopy = 0;
    String formatedValue = displayFormat(format);
    for (int i = 0; i < formatedValue.length; i++) {
      if (indexValueCopy < value.length) {
        if (_formatDigits.contains(format[i])) {
          formatedValue =
              formatedValue.replaceRange(i, 1, value[indexValueCopy]);
          indexValueCopy++;
        }
      } else {
        break;
      }
    }
    return formatedValue;

    /*
    String result = format;
    final index = [0, 1, 3, 4, 6, 7, 8, 9];
    final length = min(index.length, value.length);
    for (int i = 0; i < length; i++) {
    result = result.replaceRange(index[i], index[i] + 1, value[i]);
    }
    return result;
    */
  }

  static String displayFormat(String format, {String emptySpace = ' '}) {
    String displayFormat = format;
    for (int i = 0; i < _formatDigits.length; i++) {
      displayFormat = displayFormat.replaceAll(_formatDigits[i], emptySpace);
    }
    return displayFormat;
  }

  static bool validDigit(String digit, digitFormat) {
    return true;
    /*
    switch(digitFormat) {
      case '*': return true; //any characters
      case 'A': Rege //only numbers
      case '0': //only numbers
      case '@': //only numbers
      case 'y': return (int.tryParse(digit) != null); //only numbers
      default: return false;
    }
    */
  }

  static int nextDigitablePosition(String format, int positionInsertDigit) {
    while (positionInsertDigit < format.length && !_formatDigits.contains(format[positionInsertDigit])){
      positionInsertDigit++;
    }
    return positionInsertDigit;
  }

  static extractValue(String formatedValue, String format) {
    String value = '';
    for (int i = 0; i < format.length; i++) {
      if (i < formatedValue.length) {
        if (_formatDigits.contains(format[i])) {
          value += formatedValue[i];
        }
      } else {
        break;
      }
    }
    return value;
  }
}
