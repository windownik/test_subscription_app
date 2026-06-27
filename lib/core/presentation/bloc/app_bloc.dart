import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/locale/app_language.dart';
import 'package:test_payment_app/core/locale/domain/repositories/language_repository.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/core/presentation/loading_layout.dart';
import 'package:test_payment_app/core/router/loading_routes.dart';
import 'package:test_payment_app/features/home/home_routes.dart';
import 'package:test_payment_app/features/onboarding/onboarding_routes.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/domain/entities/tariff_plans.dart';
import 'package:test_payment_app/features/subscription/domain/repositories/subscription_plan_repository.dart';
import 'package:test_payment_app/features/subscription/domain/repositories/tariff_plans_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required SubscriptionPlanRepository subscriptionPlanRepository,
    required LanguageRepository languageRepository,
    required TariffPlansRepository tariffPlansRepository,
  })  : _subscriptionPlanRepository = subscriptionPlanRepository,
        _languageRepository = languageRepository,
        _tariffPlansRepository = tariffPlansRepository,
        super(const AppStateInitial()) {
    on<AppStarted>(_onStarted);
    on<AppSubscriptionPlanSelected>(_onSubscriptionPlanSelected);
    on<AppLanguageChanged>(_onLanguageChanged);
    on<AppReloadPressed>(_onReloadPressed);
    on<AppNavigationHandled>(_onNavigationHandled);
  }

  final SubscriptionPlanRepository _subscriptionPlanRepository;
  final LanguageRepository _languageRepository;
  final TariffPlansRepository _tariffPlansRepository;

  Future<void> _onStarted(AppStarted event, Emitter<AppState> emit) async {
    final tariffPlansResult = await _tariffPlansRepository.getTariffPlans();
    final TariffPlans? tariffPlans = tariffPlansResult.fold(
      (_) => null,
      (plans) => plans,
    );

    await emit.onEach(
      _watchCombinedState(),
      onData: (data) async {
        final (selectedPlan, language) = data;
        await _emitCombinedState(
          emit,
          selectedPlan: selectedPlan,
          language: language,
          tariffPlans: tariffPlans,
        );
      },
      onError: (error, stackTrace) {
        emit(
          const AppStateFailure(navigationRoute: LoadingRoutes.root),
        );
      },
    );
  }

  Future<void> _emitCombinedState(
    Emitter<AppState> emit, {
    required SubscriptionPlan? selectedPlan,
    required AppLanguage language,
    required TariffPlans? tariffPlans,
  }) async {
    final previous = state;

    final navigationRoute = _resolveNavigationRoute(
      previous: previous,
      selectedPlan: selectedPlan,
    );

    if (previous is AppStateInitial && navigationRoute != null) {
      await Future.delayed(LoadingLayout.initialNavigationDelay);
      if (emit.isDone) {
        return;
      }
    }

    final baseState = previous is AppStateLoaded
        ? previous
        : AppStateLoaded(
            selectedPlan: null,
            language: AppLanguage.ru,
            tariffPlans: tariffPlans,
          );

    emit(
      baseState.copyWith(
        selectedPlan: selectedPlan,
        language: language,
        tariffPlans: tariffPlans,
        navigationRoute: navigationRoute,
      ),
    );
  }

  Stream<(SubscriptionPlan?, AppLanguage)> _watchCombinedState() {
    final controller = StreamController<(SubscriptionPlan?, AppLanguage)>();

    var hasPlan = false;
    var hasLanguage = false;
    late SubscriptionPlan? selectedPlan;
    late AppLanguage language;

    void emitIfReady() {
      if (hasPlan && hasLanguage) {
        controller.add((selectedPlan, language));
      }
    }

    final subscriptions = <StreamSubscription<dynamic>>[
      _subscriptionPlanRepository.watchSelectedPlan().listen(
        (plan) {
          selectedPlan = plan;
          hasPlan = true;
          emitIfReady();
        },
        onError: controller.addError,
      ),
      _languageRepository.watchLanguage().listen(
        (savedLanguage) {
          language = savedLanguage;
          hasLanguage = true;
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

  Future<void> _onSubscriptionPlanSelected(
    AppSubscriptionPlanSelected event,
    Emitter<AppState> emit,
  ) async {
    final result = await _subscriptionPlanRepository.selectPlan(event.plan);

    await result.fold(
      (failure) async {
        emit(const AppStateFailure(navigationRoute: LoadingRoutes.root));
      },
      (_) async {
        final current = state;
        if (current is! AppStateLoaded) {
          return;
        }

        await _emitCombinedState(
          emit,
          selectedPlan: event.plan,
          language: current.language,
          tariffPlans: current.tariffPlans,
        );
      },
    );
  }

  Future<void> _onLanguageChanged(
    AppLanguageChanged event,
    Emitter<AppState> emit,
  ) async {
    final result = await _languageRepository.setLanguage(event.language);

    await result.fold(
      (failure) async {
        emit(const AppStateFailure(navigationRoute: LoadingRoutes.root));
      },
      (_) async {
        final current = state;
        if (current is! AppStateLoaded) {
          return;
        }

        await _emitCombinedState(
          emit,
          selectedPlan: current.selectedPlan,
          language: event.language,
          tariffPlans: current.tariffPlans,
        );
      },
    );
  }

  Future<void> _onReloadPressed(
    AppReloadPressed event,
    Emitter<AppState> emit,
  ) async {
    final current = state;
    if (current is! AppStateLoaded) {
      return;
    }

    final results = await Future.wait([
      _subscriptionPlanRepository.clearSelectedPlan(),
      _languageRepository.clearLanguage(),
    ]);

    final hasFailure = results.any((result) => result.isLeft());
    if (hasFailure) {
      emit(const AppStateFailure(navigationRoute: LoadingRoutes.root));
      return;
    }

    await _emitCombinedState(
      emit,
      selectedPlan: null,
      language: AppLanguage.ru,
      tariffPlans: current.tariffPlans,
    );
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
    required SubscriptionPlan? selectedPlan,
  }) {
    final shouldShowHome = selectedPlan != null;

    switch (previous) {
      case AppStateInitial():
      case AppStateFailure():
        return shouldShowHome ? HomeRoutes.main : OnboardingRoutes.root;
      case AppStateLoaded(selectedPlan: final previousPlan):
        final previousShouldShowHome = previousPlan != null;

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
