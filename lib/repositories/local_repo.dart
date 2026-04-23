import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/models/city_model.dart';
import 'package:simple_weather/theme/theme.dart';

class ThemeRepo {
  static const String _themeKey = 'selected_theme';
  late final SharedPreferencesWithCache _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(allowList: {_themeKey}),
    );
  }

  void saveTheme(ThemeModeEnum mode) {
    _prefs.setString(_themeKey, mode.name);
  }

  ThemeModeEnum getTheme() {
    final savedTheme = _prefs.getString(_themeKey);
    return ThemeModeEnum.values.firstWhere(
      (e) => e.name == savedTheme,
      orElse: () => ThemeModeEnum.system,
    );
  }
}

class CityRepo {
  static const String _cityKey = 'selected_city_data';
  late final SharedPreferencesWithCache _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {_cityKey},
      ),
    );
  }

  void saveCity(CityModel city) {
    _prefs.setString(_cityKey, jsonEncode(city.toMap()));
  }

  CityModel? getSavedCity() {
    final data = _prefs.getString(_cityKey);
    if (data == null) return null;
    return CityModel.fromMap(jsonDecode(data));
  }
}
