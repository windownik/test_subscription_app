import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/locale/app_language.dart';

class AppLocaleScope extends InheritedWidget {
  final AppLanguage language;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const AppLocaleScope({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    required super.child,
  });

  static AppLocaleScope of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppLocaleScope>();

    assert(scope != null, 'AppLocaleScope not found in widget tree');

    return scope!;
  }

  void toggleLanguage() {
    onLanguageChanged(language.opposite);
  }

  @override
  bool updateShouldNotify(AppLocaleScope oldWidget) {
    return language != oldWidget.language;
  }
}
