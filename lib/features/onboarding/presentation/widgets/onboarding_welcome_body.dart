import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';

class OnboardingWelcomeBody extends StatelessWidget {
  final String welcomeText;
  final VoidCallback onContinue;

  const OnboardingWelcomeBody({
    super.key,
    required this.welcomeText,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onContinue,
      child: Padding(
        padding: const EdgeInsets.all(OnboardingLayout.screenPadding),
        child: Center(
          child: Text(
            welcomeText,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
