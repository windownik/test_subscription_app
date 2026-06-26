import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_payment_app/core/presentation/screens/loading_screen.dart';
import 'package:test_payment_app/core/router/loading_routes.dart';
import 'package:test_payment_app/features/home/home_routes.dart';
import 'package:test_payment_app/features/home/presentation/screens/home_screen.dart';
import 'package:test_payment_app/features/onboarding/onboarding_routes.dart';
import 'package:test_payment_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:test_payment_app/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:test_payment_app/features/subscription/subscription_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: LoadingRoutes.root,
  routes: [
    GoRoute(
      path: LoadingRoutes.root,
      builder: (context, state) => const LoadingScreen(),
    ),
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
