import 'package:test_payment_app/core/locale/app_language.dart';
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
    required this.language,
    this.navigationRoute,
  });

  final bool onboardingCompleted;
  final SubscriptionPlan? selectedPlan;
  final bool shouldShowHome;
  final AppLanguage language;
  @override
  final String? navigationRoute;

  AppStateLoaded copyWith({
    bool? onboardingCompleted,
    SubscriptionPlan? selectedPlan,
    bool? shouldShowHome,
    AppLanguage? language,
    String? navigationRoute,
    bool clearNavigationRoute = false,
  }) {
    final resolvedPlan = selectedPlan ?? this.selectedPlan;

    return AppStateLoaded(
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      selectedPlan: resolvedPlan,
      shouldShowHome: shouldShowHome ?? (resolvedPlan != null),
      language: language ?? this.language,
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
