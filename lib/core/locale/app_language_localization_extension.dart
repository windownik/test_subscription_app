import 'package:test_payment_app/core/locale/app_language.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

extension AppLanguageLocalization on AppLanguage {
  String symbol(AppLocalizations l10n) {
    return switch (this) {
      AppLanguage.en => l10n.languageEnSymbol,
      AppLanguage.ru => l10n.languageRuSymbol,
    };
  }

  String languageChangedMessage(AppLocalizations l10n) {
    return switch (this) {
      AppLanguage.ru => l10n.languageChangedToRussian,
      AppLanguage.en => l10n.languageChangedToEnglish,
    };
  }
}
