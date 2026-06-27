// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get payApp => 'Pay app';

  @override
  String get welcomeToApp => 'Добро пожаловать';

  @override
  String get startWork => 'Начать работу';

  @override
  String get noSubscription => 'У вас нет подписки, выберите план';

  @override
  String get monthlyPlan => 'Помесячный';

  @override
  String get yearlyPlan => 'Годовой';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get paymentCreateOrder => 'Создаём заказ…';

  @override
  String get paymentCheckMoney => 'Проверяем оплату…';

  @override
  String get paymentSuccess => 'Оплата прошла успешно';

  @override
  String get paymentError => 'Ошибка оплаты';

  @override
  String get paymentFailed => 'Не удалось выполнить оплату';

  @override
  String get ok => 'OK';

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

  @override
  String get languageChangedToRussian => 'Язык сменен на русский';

  @override
  String get languageChangedToEnglish => 'Язык сменен на английский';

  @override
  String get databaseFullyCleared => 'База данных полностью очищена';

  @override
  String planPricePerMonth(String price) {
    return '$price / мес.';
  }

  @override
  String planPricePerYear(String price) {
    return '$price / год';
  }

  @override
  String yearlyPlanDiscount(int discountPercent) {
    return 'Скидка $discountPercent%';
  }
}
