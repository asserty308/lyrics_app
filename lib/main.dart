import 'package:flutter/material.dart';
import 'package:flutter_core/modules/i18n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lyrics/features/main/ui/screens/main_screen.dart';

Locale globalDeviceLocale = Locale('en');

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en'),
        Locale('de')
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // assign device locale for proper lyrics translation
        globalDeviceLocale = deviceLocale;

        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == deviceLocale.languageCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use english
        return supportedLocales.first;
      },
      home: MainScreen(),
    );
  }
}