// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get mainScreen => 'Main screen';

  @override
  String selectedPlan(String planName) {
    return 'Selected plan: $planName';
  }

  @override
  String get languageEnSymbol => 'EN';

  @override
  String get languageRuSymbol => 'RU';
}
