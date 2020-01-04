import 'package:flutter/material.dart';
import 'package:lyrics/core/i18n/localization_helper.dart';
import 'package:lyrics/core/ui/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      debugShowCheckedModeBanner: false,
      supportedLocales: MyLocalization.supportedLocales,
      localizationsDelegates: MyLocalization.localizationsDelegates,
      localeResolutionCallback: (device, supported) => MyLocalization.localeResolutionCallback(device, supported),
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}