import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_payment_app/core/di/injection.dart';
import 'package:test_payment_app/core/extensions/build_context_bottom_toast_extension.dart';
import 'package:test_payment_app/core/locale/app_language.dart';
import 'package:test_payment_app/core/locale/app_language_localization_extension.dart';
import 'package:test_payment_app/core/locale/app_locale_scope.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/core/router/app_router.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = getIt<AppBloc>()..add(const AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _appBloc,
      child: BlocConsumer<AppBloc, AppState>(
        listenWhen: (previous, current) =>
            current.navigationRoute != null &&
            current.navigationRoute != previous.navigationRoute,
        listener: onAppNavigation,
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType ||
            (previous is AppStateLoaded &&
                current is AppStateLoaded &&
                previous.language != current.language),
        builder: (context, state) {
          final language = switch (state) {
            AppStateLoaded(:final language) => language,
            _ => AppLanguage.ru,
          };

          return AppLocaleScope(
            language: language,
            onLanguageChanged: onLanguageChanged,
            child: CupertinoApp.router(
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.welcomeToApp,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: language.locale,
              routerConfig: appRouter,
            ),
          );
        },
      ),
    );
  }

  void onAppNavigation(BuildContext context, AppState state) {
    final route = state.navigationRoute;
    if (route == null) {
      return;
    }

    appRouter.go(route);
    _appBloc.add(const AppNavigationHandled());
  }

  void onLanguageChanged(AppLanguage language) {
    _appBloc.add(AppLanguageChanged(language));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        return;
      }

      final l10n = AppLocalizations.of(context)!;
      context.showBottomToast(language.languageChangedMessage(l10n));
    });
  }
}
