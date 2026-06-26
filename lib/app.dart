import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_payment_app/core/locale/app_language.dart';
import 'package:test_payment_app/core/locale/app_locale_scope.dart';
import 'package:test_payment_app/core/router/app_router.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppLanguage _language = AppLanguage.ru;

  @override
  Widget build(BuildContext context) {
    return AppLocaleScope(
      language: _language,
      onLanguageChanged: onLanguageChanged,
      child: CupertinoApp.router(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.welcomeToApp,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _language.locale,
        routerConfig: appRouter,
      ),
    );
  }

  void onLanguageChanged(AppLanguage language) {
    setState(() => _language = language);
  }
}
