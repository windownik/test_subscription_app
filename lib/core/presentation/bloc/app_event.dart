import 'package:test_payment_app/core/locale/app_language.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppStarted extends AppEvent {
  const AppStarted();
}

final class AppSubscriptionPlanSelected extends AppEvent {
  const AppSubscriptionPlanSelected(this.plan);

  final SubscriptionPlan plan;
}

final class AppReloadPressed extends AppEvent {
  const AppReloadPressed();
}

final class AppRetryPressed extends AppEvent {
  const AppRetryPressed();
}

final class AppLanguageChanged extends AppEvent {
  const AppLanguageChanged(this.language);

  final AppLanguage language;
}

final class AppNavigationHandled extends AppEvent {
  const AppNavigationHandled();
}
