import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/core/router/loading_routes.dart';
import 'package:test_payment_app/features/home/home_routes.dart';
import 'package:test_payment_app/features/onboarding/onboarding_routes.dart';
import 'package:test_payment_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/domain/repositories/subscription_plan_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this._onboardingRepository,
    required this._subscriptionPlanRepository,
  }) : super(const AppStateInitial()) {
    on<AppStarted>(_onStarted);
    on<AppOnboardingCompleted>(_onOnboardingCompleted);
    on<AppSubscriptionPlanSelected>(_onSubscriptionPlanSelected);
    on<AppReloadPressed>(_onReloadPressed);
    on<AppNavigationHandled>(_onNavigationHandled);
  }

  final OnboardingRepository _onboardingRepository;
  final SubscriptionPlanRepository _subscriptionPlanRepository;

  Future<void> _onStarted(AppStarted event, Emitter<AppState> emit) async {
    await emit.forEach(
      _watchCombinedState(),
      onData: (data) {
        final (onboardingCompleted, selectedPlan) = data;
        final shouldShowHome = selectedPlan != null;
        final previous = state;

        final baseState = previous is AppStateLoaded
            ? previous
            : const AppStateLoaded(
                onboardingCompleted: false,
                selectedPlan: null,
                shouldShowHome: false,
              );

        return baseState.copyWith(
          onboardingCompleted: onboardingCompleted,
          selectedPlan: selectedPlan,
          shouldShowHome: shouldShowHome,
          navigationRoute: _resolveNavigationRoute(
            previous: previous,
            shouldShowHome: shouldShowHome,
          ),
        );
      },
      onError: (_, _) => const AppStateFailure(
        navigationRoute: LoadingRoutes.root,
      ),
    );
  }

  Stream<(bool, SubscriptionPlan?)> _watchCombinedState() {
    final controller = StreamController<(bool, SubscriptionPlan?)>();

    var hasOnboarding = false;
    var hasPlan = false;
    late bool onboardingCompleted;
    late SubscriptionPlan? selectedPlan;

    void emitIfReady() {
      if (hasOnboarding && hasPlan) {
        controller.add((onboardingCompleted, selectedPlan));
      }
    }

    final subscriptions = <StreamSubscription<dynamic>>[
      _onboardingRepository.watchOnboardingCompleted().listen(
        (completed) {
          onboardingCompleted = completed;
          hasOnboarding = true;
          emitIfReady();
        },
        onError: controller.addError,
      ),
      _subscriptionPlanRepository.watchSelectedPlan().listen(
        (plan) {
          selectedPlan = plan;
          hasPlan = true;
          emitIfReady();
        },
        onError: controller.addError,
      ),
    ];

    controller.onCancel = () async {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    };

    return controller.stream;
  }

  Future<void> _onOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    final result = await _onboardingRepository.setOnboardingCompleted(
      completed: true,
    );

    result.fold(
      (_) => emit(
        const AppStateFailure(navigationRoute: LoadingRoutes.root),
      ),
      (_) {},
    );
  }

  Future<void> _onSubscriptionPlanSelected(
    AppSubscriptionPlanSelected event,
    Emitter<AppState> emit,
  ) async {
    final result = await _subscriptionPlanRepository.selectPlan(event.plan);

    result.fold(
      (_) => emit(
        const AppStateFailure(navigationRoute: LoadingRoutes.root),
      ),
      (_) {},
    );
  }

  Future<void> _onReloadPressed(
    AppReloadPressed event,
    Emitter<AppState> emit,
  ) async {
    final results = await Future.wait([
      _onboardingRepository.clearOnboardingData(),
      _subscriptionPlanRepository.clearSelectedPlan(),
    ]);

    final hasFailure = results.any((result) => result.isLeft());
    if (hasFailure) {
      emit(const AppStateFailure(navigationRoute: LoadingRoutes.root));
    }
  }

  void _onNavigationHandled(
    AppNavigationHandled event,
    Emitter<AppState> emit,
  ) {
    final current = state;

    switch (current) {
      case AppStateLoaded():
        emit(current.copyWith(clearNavigationRoute: true));
      case AppStateFailure():
        emit(const AppStateFailure());
      case AppStateInitial():
        return;
    }
  }

  String? _resolveNavigationRoute({
    required AppState previous,
    required bool shouldShowHome,
  }) {
    switch (previous) {
      case AppStateInitial():
      case AppStateFailure():
        return shouldShowHome ? HomeRoutes.main : OnboardingRoutes.root;
      case AppStateLoaded(shouldShowHome: final previousShouldShowHome):
        if (shouldShowHome && !previousShouldShowHome) {
          return HomeRoutes.main;
        }

        if (!shouldShowHome && previousShouldShowHome) {
          return OnboardingRoutes.root;
        }

        return null;
    }
  }
}
