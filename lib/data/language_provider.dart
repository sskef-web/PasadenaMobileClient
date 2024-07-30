import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale currentLocale = Locale('ru');

  Future<void> getLocaleFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString('locale');
    if (locale == '') {
      currentLocale = Locale('ru');
    }
    else {
      currentLocale = Locale('${locale!}');
    }
    debugPrint('GET LOCALE - ${locale}');
  }

  Future<void> setLocaleOnLocalStorage(Locale value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', '${value}');
    debugPrint('SET PROVIDER - ${value}');
  }

  Locale getLocale() {
    return Locale('${getLocaleFromLocalStorage()}');
  }

  Locale get locale => currentLocale;

  void changeLanguage(Locale newLocale) {
    currentLocale = newLocale;
    notifyListeners();
    setLocaleOnLocalStorage(newLocale);
  }
}