// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get payApp => 'Pay app';

  @override
  String get welcomeToApp => 'Welcome to app';

  @override
  String get startWork => 'Start work';

  @override
  String get noSubscription => 'You don\'t have a subscription, choose a plan';

  @override
  String get monthlyPlan => 'Monthly';

  @override
  String get yearlyPlan => 'Yearly';

  @override
  String get continueButton => 'Continue';

  @override
  String get paymentCreateOrder => 'Creating order…';

  @override
  String get paymentCheckMoney => 'Checking payment…';

  @override
  String get paymentSuccess => 'Payment successful';

  @override
  String get paymentError => 'Payment failed';

  @override
  String get paymentFailed => 'Payment failed';

  @override
  String get ok => 'OK';

  @override
  String get mainScreen => 'Main screen';

  @override
  String selectedPlan(String planName) {
    return 'Selected plan: $planName';
  }

  @override
  String get languageEnSymbol => 'EN';

  @override
  String get languageRuSymbol => 'RU';

  @override
  String get languageChangedToRussian => 'Language changed to Russian';

  @override
  String get languageChangedToEnglish => 'Language changed to English';

  @override
  String get databaseFullyCleared => 'Database completely cleared';
}
