import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

sealed class AppState {
  const AppState();
}

final class AppStateInitial extends AppState {
  const AppStateInitial();
}

final class AppStateLoaded extends AppState {
  const AppStateLoaded({
    required this.onboardingCompleted,
    required this.selectedPlan,
  });

  final bool onboardingCompleted;
  final SubscriptionPlan? selectedPlan;
}

final class AppStateFailure extends AppState {
  const AppStateFailure();
}
