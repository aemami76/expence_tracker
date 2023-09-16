import 'package:expence_tracker/expence_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeData _theme = ThemeData.dark();

class _MyAppState extends State<MyApp> {
  ColorScheme kScheme = ColorScheme.fromSeed(seedColor: Colors.redAccent);
  void _themeChange(Color val) {
    if (val == Colors.black) {
      setState(() {
        _theme = ThemeData.dark();
      });
    } else {
      setState(() {
        kScheme = ColorScheme.fromSeed(seedColor: val);
        _theme = ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kScheme,
            appBarTheme: AppBarTheme(
                backgroundColor: kScheme.onPrimaryContainer,
                foregroundColor: kScheme.onPrimary),
            listTileTheme: ListTileThemeData(
                tileColor: kScheme.onPrimary,
                textColor: kScheme.onPrimaryContainer),
            scaffoldBackgroundColor: kScheme.background);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      home: ExpenceScreen(_themeChange),
    );
  }
}
