import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_payment_app/core/di/injection.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/core/router/app_router_refresh_notifier.dart';
import 'package:test_payment_app/features/home/home_routes.dart';
import 'package:test_payment_app/features/home/presentation/screens/home_screen.dart';
import 'package:test_payment_app/features/onboarding/onboarding_routes.dart';
import 'package:test_payment_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:test_payment_app/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:test_payment_app/features/subscription/subscription_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final _appRouterRefreshNotifier = AppRouterRefreshNotifier(getIt<AppBloc>());

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: OnboardingRoutes.root,
  refreshListenable: _appRouterRefreshNotifier,
  redirect: (context, state) {
    final appState = getIt<AppBloc>().state;
    if (appState is! AppStateLoaded) {
      return null;
    }

    if (appState.shouldShowHome) {
      if (state.matchedLocation == HomeRoutes.main) {
        return null;
      }

      return HomeRoutes.main;
    }

    if (state.matchedLocation == HomeRoutes.main) {
      return OnboardingRoutes.root;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: OnboardingRoutes.root,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: SubscriptionRoutes.plans,
      builder: (context, state) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: HomeRoutes.main,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
