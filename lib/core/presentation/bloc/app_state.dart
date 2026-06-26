import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

sealed class AppState {
  const AppState();

  String? get navigationRoute => null;
}

final class AppStateInitial extends AppState {
  const AppStateInitial();
}

final class AppStateLoaded extends AppState {
  const AppStateLoaded({
    required this.onboardingCompleted,
    required this.selectedPlan,
    required this.shouldShowHome,
    this.navigationRoute,
  });

  final bool onboardingCompleted;
  final SubscriptionPlan? selectedPlan;
  final bool shouldShowHome;
  @override
  final String? navigationRoute;

  AppStateLoaded copyWith({
    bool? onboardingCompleted,
    SubscriptionPlan? selectedPlan,
    bool? shouldShowHome,
    String? navigationRoute,
    bool clearNavigationRoute = false,
  }) {
    final resolvedPlan = selectedPlan ?? this.selectedPlan;

    return AppStateLoaded(
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      selectedPlan: resolvedPlan,
      shouldShowHome: shouldShowHome ?? (resolvedPlan != null),
      navigationRoute: clearNavigationRoute
          ? null
          : (navigationRoute ?? this.navigationRoute),
    );
  }
}

final class AppStateFailure extends AppState {
  const AppStateFailure({this.navigationRoute});

  @override
  final String? navigationRoute;
}
