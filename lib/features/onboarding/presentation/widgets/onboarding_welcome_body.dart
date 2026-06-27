import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';

class OnboardingWelcomeBody extends StatelessWidget {
  final String welcomeText;
  final String subscriptionOptionText;
  final String tapToContinueText;
  final VoidCallback onContinue;

  const OnboardingWelcomeBody({
    super.key,
    required this.welcomeText,
    required this.subscriptionOptionText,
    required this.tapToContinueText,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;
    final welcomeStyle = textStyle.copyWith(
      fontSize: OnboardingLayout.welcomeTitleFontSize,
      fontWeight: FontWeight.w600,
    );
    final subtitleStyle = textStyle.copyWith(
      color: CupertinoColors.secondaryLabel.resolveFrom(context),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onContinue,
      child: Padding(
        padding: const EdgeInsets.all(OnboardingLayout.screenPadding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                welcomeText,
                style: welcomeStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: OnboardingLayout.contentSpacing),
              Text(
                subscriptionOptionText,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: OnboardingLayout.subtitleTopSpacing),
              Text(
                tapToContinueText,
                style: subtitleStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
