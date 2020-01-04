import 'package:flutter/material.dart';
import 'package:lyrics/core/i18n/localization_helper.dart';
import 'package:lyrics/core/ui/screens/main_screen.dart';

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
      supportedLocales: MyLocalization.supportedLocales,
      localizationsDelegates: MyLocalization.localizationsDelegates,
      localeResolutionCallback: (deviceLocale, supportedLocales) => MyLocalization.localeResolutionCallback(deviceLocale, supportedLocales),
      home: MainScreen(),
    );
  }
}