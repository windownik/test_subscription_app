import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';
import 'package:test_payment_app/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:test_payment_app/features/onboarding/presentation/widgets/onboarding_start_body.dart';
import 'package:test_payment_app/features/subscription/subscription_routes.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class OnboardingStartScreen extends StatelessWidget {
  const OnboardingStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: OnboardingStartBody(
                startWorkLabel: l10n.startWork,
                onStartWorkPressed: () => onStartWorkPressed(context),
              ),
            ),
            const OnboardingPageIndicator(
              currentPageIndex: 1,
              pageCount: OnboardingLayout.onboardingPageCount,
            ),
          ],
        ),
      ),
    );
  }

  void onStartWorkPressed(BuildContext context) {
    context.push(SubscriptionRoutes.plans);
  }
}
