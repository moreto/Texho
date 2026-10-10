import 'package:commons/log.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class AppConfig extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  AppFont _font = AppFont.nunito;
  Locale? _locale;

  ThemeMode get mode => _mode;
  AppFont get font => _font;
  Locale? get locale => _locale;

  void setMode(ThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;

    notifyListeners();
  }

  void setFont(AppFont font) {
    if (_font == font) return;
    _font = font;
    Log.print(font, title: 'Fonte selecionada');
    notifyListeners();
  }

  void setLocale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
