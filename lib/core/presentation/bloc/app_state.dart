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
    required this.shouldShowHome,
  });

  final bool onboardingCompleted;
  final SubscriptionPlan? selectedPlan;
  final bool shouldShowHome;
}

final class AppStateFailure extends AppState {
  const AppStateFailure();
}
