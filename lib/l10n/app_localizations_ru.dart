// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcomeToApp => 'Добро пожаловать';

  @override
  String get startWork => 'Начать работу';

  @override
  String get noSubscription => 'У вас нет подписки, выберите план';

  @override
  String get monthlyPlan => 'Помесячная';

  @override
  String get yearlyPlan => 'Годовая';

  @override
  String get mainScreen => 'Главный экран';

  @override
  String selectedPlan(String planName) {
    return 'Выбранный тарифный план: $planName';
  }

  @override
  String get languageEnSymbol => 'EN';

  @override
  String get languageRuSymbol => 'RU';
}
