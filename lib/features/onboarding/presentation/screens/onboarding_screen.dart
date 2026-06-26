import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';
import 'package:test_payment_app/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:test_payment_app/features/onboarding/presentation/widgets/onboarding_start_body.dart';
import 'package:test_payment_app/features/onboarding/presentation/widgets/onboarding_welcome_body.dart';
import 'package:test_payment_app/features/subscription/subscription_routes.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: [
              OnboardingWelcomeBody(
                welcomeText: l10n.welcomeToApp,
                onContinue: onContinuePressed,
              ),
              OnboardingStartBody(
                startWorkLabel: l10n.startWork,
                onStartWorkPressed: () => onStartWorkPressed(context),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: OnboardingPageIndicator(
                currentPageIndex: _currentPageIndex,
                pageCount: OnboardingLayout.onboardingPageCount,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onContinuePressed() {
    _pageController.nextPage(
      duration: OnboardingLayout.pageTransitionDuration,
      curve: Curves.easeInOut,
    );
  }

  void onStartWorkPressed(BuildContext context) {
    context.push(SubscriptionRoutes.plans);
  }

  void onPageChanged(int index) {
    setState(() => _currentPageIndex = index);
  }
}
