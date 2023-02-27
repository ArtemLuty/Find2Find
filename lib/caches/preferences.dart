import 'dart:developer';
import 'package:hive/hive.dart';

class Preferences {
  static const _preferencesBox = '_preferencesBox';
  static const _firstLaunch = '_firstLaunch';
  static const _darkMode = '_darkMode';
  static const _currentLanguage = '_currentLanguage';
  static const _biometricsEnabled = '_biometricsEnabled';
  static const _essentialEnabled = '_essentialEnabled';
  static const _performanceEnabled = '_performanceEnabled';
  static const _personalisationEnabled = '_personalisationEnabled';

  Box<dynamic>? _box;

  Future openBox() async {
    this._box = await Hive.openBox<dynamic>(_preferencesBox);
  }

  bool isFirstLaunch() => _getValue(_firstLaunch) ?? true;

  Future<void> setFirstLaunch(bool firstLaunch) =>
      _setValue(_firstLaunch, firstLaunch);

  bool darkMode() => _getValue(_darkMode) ?? false;

  Future<void> setDarkMode(bool darkMode) => _setValue(_darkMode, darkMode);

  getLanguage() => _getValue(_currentLanguage);

  Future<void> setLanguage(String language) =>
      _setValue(_currentLanguage, language);

  getBiometricsEnabled() => _getValue(_biometricsEnabled) ?? false;

  Future<void> setBiometricsEnabled(bool enabled) =>
      _setValue(_biometricsEnabled, enabled);


  getEssentialEnabled() => _getValue(_essentialEnabled) ?? false;

  Future<void> setEssentialEnabled(bool enabled) =>
      _setValue(_essentialEnabled, enabled);

  getPerformanceEnabled() => _getValue(_performanceEnabled) ?? false;

  Future<void> setPerformanceEnabled(bool enabled) =>
      _setValue(_performanceEnabled, enabled);

  getPersonalisationEnabled() => _getValue(_personalisationEnabled) ?? false;

  Future<void> setPersonalisationEnabled(bool enabled) =>
      _setValue(_personalisationEnabled, enabled);

  T _getValue<T>(dynamic key, {T? defaultValue}) {
    log("Cache => Received ${_box!.get(key, defaultValue: defaultValue) as T} from $key");
    return _box!.get(key, defaultValue: defaultValue) as T;
  }

  Future<void> _setValue<T>(dynamic key, T value) {
    log("Cache => Setting $key to $value");
    return _box!.put(key, value);
  }

  Future<void> clearCache() {
    return _box!.clear();
  }
}
