import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

extension SubscriptionPlanLocalization on SubscriptionPlan {
  String label(AppLocalizations l10n) {
    return switch (this) {
      SubscriptionPlan.monthly => l10n.monthlyPlan,
      SubscriptionPlan.yearly => l10n.yearlyPlan,
    };
  }
}
