// creating custom colors to be used throughout the app

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rokney/screens/screens.dart';

// FOR LIGHT MODE DESIGN

class ColorPalette {
  final Color buttonColor = Colors.blue; // for all the buttons
  final Color appBarColor = Colors.blue; // for the appBar
  final scaffoldColor = Colors.white;
  final Color indicatorColor =
      Colors.blue; // for all indicators like progress indicator
  Color mainColor = const Color.fromRGBO(11, 77, 110, 1);

  Color darkForeground(BuildContext context) {
    var darkModeBackgroundColor =
        Theme.of(context).primaryTextTheme.bodyText1!.color;

    return darkModeBackgroundColor!;
  }
}

// FOR DARK MODE DESIGN
class DarkColorPalette {
  final Color scaffoldBackgroundColor =
      Colors.black; // for the background of the app
  final Color textColor = Colors.white; // foreground color
}

// creating a notifier for theme (light and dark mode)
class ThemeNotifier with ChangeNotifier {
  // for light theme
  final lightTheme = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: Colors.deepOrange,
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.grey)),
      primarySwatch: Colors.deepOrange);

  final darkTheme = ThemeData(
      backgroundColor: Colors.black,
      primarySwatch: Colors.deepOrange,
      primaryColor: Colors.deepOrange,
      indicatorColor: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.grey)));

  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    // reading value from the shared preference
    ThemeStorageManager().getThemeType('themeMode').then((value) {
      var _themeMode = value ?? 'light';
      if (_themeMode == 'light') {
        _themeData = lightTheme;
        getTheme();
      } else {
        _themeData = darkTheme;
        getTheme();
      }

      notifyListeners();
    });
  }
  // set light mode
  void setLightMode() async {
    _themeData = lightTheme;
    ThemeStorageManager().setTheme('light');
    notifyListeners();
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    ThemeStorageManager().setTheme('dark');
    notifyListeners();
  }
}
