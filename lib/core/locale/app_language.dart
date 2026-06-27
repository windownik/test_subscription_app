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

  static AppLanguage fromStorageValue(String? value) {
    return switch (value) {
      'en' => AppLanguage.en,
      'ru' => AppLanguage.ru,
      _ => AppLanguage.ru,
    };
  }
}
