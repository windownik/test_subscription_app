import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
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
  }

  final OnboardingRepository _onboardingRepository;
  final SubscriptionPlanRepository _subscriptionPlanRepository;

  bool _onboardingCompleted = false;
  SubscriptionPlan? _selectedPlan;

  AppState _buildLoadedState() {
    return AppStateLoaded(
      onboardingCompleted: _onboardingCompleted,
      selectedPlan: _selectedPlan,
    );
  }

  Future<void> _onStarted(
    AppStarted event,
    Emitter<AppState> emit,
  ) async {
    await Future.wait([
      emit.forEach<bool>(
        _onboardingRepository.watchOnboardingCompleted(),
        onData: (completed) {
          _onboardingCompleted = completed;
          return _buildLoadedState();
        },
        onError: (_, _) => const AppStateFailure(),
      ),
      emit.forEach<SubscriptionPlan?>(
        _subscriptionPlanRepository.watchSelectedPlan(),
        onData: (plan) {
          _selectedPlan = plan;
          return _buildLoadedState();
        },
        onError: (_, _) => const AppStateFailure(),
      ),
    ]);
  }

  Future<void> _onOnboardingCompleted(
    AppOnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    final result = await _onboardingRepository.setOnboardingCompleted(
      completed: true,
    );

    result.fold(
      (_) => emit(const AppStateFailure()),
      (_) {},
    );
  }

  Future<void> _onSubscriptionPlanSelected(
    AppSubscriptionPlanSelected event,
    Emitter<AppState> emit,
  ) async {
    final result = await _subscriptionPlanRepository.selectPlan(event.plan);

    result.fold(
      (_) => emit(const AppStateFailure()),
      (_) {},
    );
  }
}
