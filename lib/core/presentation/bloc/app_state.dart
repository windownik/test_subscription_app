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
    required this.selectedPlan,
    required this.language,
    this.navigationRoute,
  });

  final SubscriptionPlan? selectedPlan;
  final AppLanguage language;
  @override
  final String? navigationRoute;

  static const Object _selectedPlanUnset = Object();

  AppStateLoaded copyWith({
    Object? selectedPlan = _selectedPlanUnset,
    AppLanguage? language,
    String? navigationRoute,
    bool clearNavigationRoute = false,
  }) {
    return AppStateLoaded(
      selectedPlan: identical(selectedPlan, _selectedPlanUnset)
          ? this.selectedPlan
          : selectedPlan as SubscriptionPlan?,
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
