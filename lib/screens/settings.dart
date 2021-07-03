import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

// for the app's settings
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool? switchState;

  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();

    ThemeStorageManager().getThemeType("themeMode").then((themeMode) {
      switch (themeMode) {
        case 'light':
          switchState =
              false; // does'nt activate if the theme mode is in light mode
          setState(() {});
          break;
        case 'dark':
          switchState =
              true; // activates the switch button if the themeMode is in dark mode
          setState(() {});
          break;
        default:
          switchState = false;
      }
    });
  }

  onSwitchChange(bool switchValue) {
    ThemeStorageManager().getThemeType("themeMode").then((value) {
      print(value);
      if (switchValue) {
        _themeNotifier.setDarkMode();
        print('on dark mode');
      } else {
        _themeNotifier.setLightMode();
        print('on light mode');
      }
    });

    setState(() {
      switchState = switchValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios)),
      backgroundColor: ColorPalette().mainColor,
      actions: [
        Align(alignment: Alignment.center, child: Text("light/dark mode")),
        Switch(
          value: switchState ?? false,
          onChanged: (switchValue) => onSwitchChange(switchValue),
          activeColor: Colors.white,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
      ],
    ));
  }
}

// creating a shared preference for controlling the theme mode
class ThemeStorageManager {
  void setTheme(String theme) async {
    final _preferences = await SharedPreferences.getInstance();
    // setting the preference to the called value
    _preferences.setString('themeMode', theme);
  }

  //  get the theme type ( either light or dark mode)
  Future<dynamic> getThemeType(String key) async {
    final _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(key);
  }
}
