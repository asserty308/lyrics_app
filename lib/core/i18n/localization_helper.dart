import 'package:flutter/material.dart';
import 'package:flutter_core/i18n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyLocalization {
  /// Will be reassigned when calling [localeResolutionCallback].
  /// Used by cloud_translation to always translate into the users language.
  static Locale deviceLocale = Locale('en');

  static final supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
  ];

  static final localizationsDelegates = <LocalizationsDelegate>[
    AppLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static Locale localeResolutionCallback(Locale deviceLocale, Iterable<Locale> supportedLocales) {
    // assign device locale for proper lyrics translation
    MyLocalization.deviceLocale = deviceLocale;

    // Check if the current device locale is supported
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode) {
        return supportedLocale;
      }
    }

    // If the locale of the device is not supported, use english
    return supportedLocales.first;
  }
}