import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_payment_app/features/home/home_routes.dart';
import 'package:test_payment_app/features/subscription/presentation/widgets/subscription_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: SubscriptionBody(
          noSubscriptionText: l10n.noSubscription,
          monthlyPlanLabel: l10n.monthlyPlan,
          yearlyPlanLabel: l10n.yearlyPlan,
          onMonthlyPlanPressed: () => onMonthlyPlanPressed(context),
          onYearlyPlanPressed: () => onYearlyPlanPressed(context),
        ),
      ),
    );
  }

  void onMonthlyPlanPressed(BuildContext context) {
    context.go(HomeRoutes.main);
  }

  void onYearlyPlanPressed(BuildContext context) {
    context.go(HomeRoutes.main);
  }
}
