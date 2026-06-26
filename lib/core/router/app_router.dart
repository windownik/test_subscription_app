import 'package:go_router/go_router.dart';
import 'package:test_payment_app/features/home/home_routes.dart';
import 'package:test_payment_app/features/home/presentation/screens/home_screen.dart';
import 'package:test_payment_app/features/onboarding/onboarding_routes.dart';
import 'package:test_payment_app/features/onboarding/presentation/screens/onboarding_start_screen.dart';
import 'package:test_payment_app/features/onboarding/presentation/screens/onboarding_welcome_screen.dart';
import 'package:test_payment_app/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:test_payment_app/features/subscription/subscription_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: OnboardingRoutes.welcome,
  routes: [
    GoRoute(
      path: OnboardingRoutes.welcome,
      builder: (context, state) => const OnboardingWelcomeScreen(),
    ),
    GoRoute(
      path: OnboardingRoutes.start,
      builder: (context, state) => const OnboardingStartScreen(),
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
