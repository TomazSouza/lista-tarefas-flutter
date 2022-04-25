import 'package:flutter/material.dart';
import 'package:lista_tarefas/theme/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  final _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  late ThemeData _themeData = _lightTheme;
  bool _isNightMode = false;

  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = _lightTheme;
        _isNightMode = false;
      } else {
        print('setting dark theme');
        _themeData = _darkTheme;
        _isNightMode = true;
      }
      notifyListeners();
    });
  }

  Future<bool> theme() async {
    var value = await StorageManager.readData('themeMode');

    var themeMode = value ?? 'light';
    if (themeMode == 'light') {
      return false;
    } else {
      return true;
    }
  }

  bool get isNightMode => _isNightMode;

  void setDarkMode() async {
    _themeData = _darkTheme;
    _isNightMode = true;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = _lightTheme;
    _isNightMode = false;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
