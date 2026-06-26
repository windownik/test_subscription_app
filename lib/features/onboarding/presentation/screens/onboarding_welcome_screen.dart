import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_payment_app/features/onboarding/onboarding_routes.dart';
import 'package:test_payment_app/features/onboarding/presentation/widgets/onboarding_welcome_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: OnboardingWelcomeBody(
          welcomeText: l10n.welcomeToApp,
          onContinue: () => context.push(OnboardingRoutes.start),
        ),
      ),
    );
  }
}
