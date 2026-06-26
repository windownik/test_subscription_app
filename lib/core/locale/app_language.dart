import 'package:flutter/cupertino.dart';

enum AppLanguage {
  en,
  ru;

  Locale get locale => Locale(name);

  AppLanguage get opposite => switch (this) {
        AppLanguage.en => AppLanguage.ru,
        AppLanguage.ru => AppLanguage.en,
      };

  String get storageValue => name;

  static AppLanguage fromLocale(Locale locale) {
    return switch (locale.languageCode) {
      'en' => AppLanguage.en,
      'ru' => AppLanguage.ru,
      _ => AppLanguage.ru,
    };
  }

  static AppLanguage fromStorageValue(String? value) {
    return switch (value) {
      'en' => AppLanguage.en,
      'ru' => AppLanguage.ru,
      _ => AppLanguage.ru,
    };
  }
}
