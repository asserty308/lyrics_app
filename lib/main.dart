import 'package:flutter/material.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // assign device locale for proper lyrics translation
        globalDeviceLocale = deviceLocale;
        return;
      },
      home: MainScreen(),
    );
  }
}