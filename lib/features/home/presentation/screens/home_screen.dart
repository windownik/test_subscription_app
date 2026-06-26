import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/locale/app_language_localization_extension.dart';
import 'package:test_payment_app/core/locale/app_locale_scope.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/features/home/presentation/widgets/home_body.dart';
import 'package:test_payment_app/features/subscription/presentation/extensions/subscription_plan_localization_extension.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final language = AppLocaleScope.of(context).language;

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          child: SafeArea(
            child: HomeBody(
              mainScreenText: l10n.mainScreen,
              selectedPlanText: resolveSelectedPlanText(l10n, state),
              languageSymbol: language.symbol(l10n),
              onReloadPressed: () => onReloadPressed(context),
              onLanguagePressed: () => onLanguagePressed(context),
            ),
          ),
        );
      },
    );
  }

  void onReloadPressed(BuildContext context) {
    context.read<AppBloc>().add(const AppReloadPressed());
  }

  void onLanguagePressed(BuildContext context) {
    AppLocaleScope.of(context).toggleLanguage();
  }

  String? resolveSelectedPlanText(AppLocalizations l10n, AppState state) {
    if (state is! AppStateLoaded) {
      return null;
    }

    final plan = state.selectedPlan;
    if (plan == null) {
      return null;
    }

    return l10n.selectedPlan(plan.label(l10n));
  }
}
