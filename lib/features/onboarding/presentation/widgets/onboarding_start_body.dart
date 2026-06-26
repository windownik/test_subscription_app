import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';

class OnboardingStartBody extends StatelessWidget {
  final String startWorkLabel;
  final VoidCallback onStartWorkPressed;

  const OnboardingStartBody({
    super.key,
    required this.startWorkLabel,
    required this.onStartWorkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(OnboardingLayout.screenPadding),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: onStartWorkPressed,
          child: Text(startWorkLabel),
        ),
      ),
    );
  }
}
