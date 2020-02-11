import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_localization/simple_localization.dart';
import 'package:simple_form/simple_form.dart';

class SimpleFormLocalization extends SimpleLocalizations {
  static SimpleFormLocalization of(BuildContext context) {
    SimpleFormLocalization localization = Localizations.of<SimpleFormLocalization>(context, SimpleFormLocalization);
    return localization ?? SimpleFormLocalization(Localizations.localeOf(context));
  }
  
  SimpleFormLocalization(Locale locale) : super(locale);

  @override
  Locale get defaultLocale => Locale('en');

  @override
  Iterable<Locale> get suportedLocales => [
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  @override
  Map<String, Map<dynamic, String>> get localizedValues => {
    'en': {
      // validators
      ValidatorsMessages.invalidDate: 'Invalid date',
      ValidatorsMessages.invalidEmail: 'Invalid email address',
      ValidatorsMessages.invalidName: 'Invalid name',
      ValidatorsMessages.invalidPhone: 'Invalid phone',
      ValidatorsMessages.requiredValidator: 'Required field',
    },
    'es': {
      // validators
      ValidatorsMessages.invalidDate: 'Fecha inválida',
      ValidatorsMessages.invalidEmail: 'Dirección de correo electrónico no válida',
      ValidatorsMessages.invalidName: 'Nombre inválido',
      ValidatorsMessages.invalidPhone: 'Teléfono inválido',
      ValidatorsMessages.requiredValidator: 'Campo obligatorio',
    },
    'pt': {
      // validators
      ValidatorsMessages.invalidDate: 'Data inválida',
      ValidatorsMessages.invalidEmail: 'Endereço de e-mail inválido',
      ValidatorsMessages.invalidName: 'Nome inválido',
      ValidatorsMessages.invalidPhone: 'Telefone inválido',
      ValidatorsMessages.requiredValidator: 'Campo obrigatório',
    }
  };
}