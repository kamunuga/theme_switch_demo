import 'package:flutter/material.dart';

import 'settings_screen.dart';

void main() => runApp(const ThemeSwitchApp());

/// Root of the app. It owns the theme state, so when the Switch on the
/// settings screen flips, MaterialApp rebuilds with the other theme.
class ThemeSwitchApp extends StatefulWidget {
  const ThemeSwitchApp({super.key});

  @override
  State<ThemeSwitchApp> createState() => _ThemeSwitchAppState();
}

class _ThemeSwitchAppState extends State<ThemeSwitchApp> {
  bool _isDarkMode = false;

  void _setDarkMode(bool value) {
    setState(() => _isDarkMode = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Switch Demo',
      debugShowCheckedModeBanner: false,
      // One light theme and one dark theme built from the same seed colour.
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      // The Switch value decides which of the two themes is used.
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SettingsScreen(
        isDarkMode: _isDarkMode,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }
}
