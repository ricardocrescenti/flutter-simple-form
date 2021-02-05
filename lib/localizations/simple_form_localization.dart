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
      ValidatorsMessages.minimumSize: 'Enter at least [min_size] characters',
      ValidatorsMessages.requiredValidator: 'Required field',
      ValidatorsMessages.cpfInvalid: 'The CPF is not valid',
      ValidatorsMessages.cpfNotComplete: 'The CPF is not complete',
      ValidatorsMessages.cnpjInvalid: 'The CNPJ is not valid',
      ValidatorsMessages.cnpjNotComplete: 'The CNPJ is not complete',
    },
    'es': {
      // validators
      ValidatorsMessages.invalidDate: 'Fecha inválida',
      ValidatorsMessages.invalidEmail: 'Dirección de correo electrónico no válida',
      ValidatorsMessages.invalidName: 'Nombre inválido',
      ValidatorsMessages.invalidPhone: 'Teléfono inválido',
      ValidatorsMessages.minimumSize: 'Ingrese al menos [min_size] caracteres',
      ValidatorsMessages.requiredValidator: 'Campo obligatorio',
      ValidatorsMessages.cpfInvalid: 'El CPF no es válido',
      ValidatorsMessages.cpfNotComplete: 'El CPF no está completo',
      ValidatorsMessages.cnpjInvalid: 'El CNPJ no es válido',
      ValidatorsMessages.cnpjNotComplete: 'El CNPJ no está completo',
    },
    'pt': {
      // validators
      ValidatorsMessages.invalidDate: 'Data inválida',
      ValidatorsMessages.invalidEmail: 'Endereço de e-mail inválido',
      ValidatorsMessages.invalidName: 'Nome inválido',
      ValidatorsMessages.invalidPhone: 'Telefone inválido',
      ValidatorsMessages.minimumSize: 'Informe pelo menos [min_size] caracteres',
      ValidatorsMessages.requiredValidator: 'Campo obrigatório',
      ValidatorsMessages.cpfInvalid: 'O CPF não é valido',
      ValidatorsMessages.cpfNotComplete: 'O CPF não está completo',
      ValidatorsMessages.cnpjInvalid: 'O CNPJ não é valido',
      ValidatorsMessages.cnpjNotComplete: 'O CNPJ não está completo',
    }
  };
}