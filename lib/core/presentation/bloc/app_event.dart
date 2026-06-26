import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppStarted extends AppEvent {
  const AppStarted();
}

final class AppOnboardingCompleted extends AppEvent {
  const AppOnboardingCompleted();
}

final class AppSubscriptionPlanSelected extends AppEvent {
  const AppSubscriptionPlanSelected(this.plan);

  final SubscriptionPlan plan;
}
