import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';

class OnboardingStartBody extends StatelessWidget {
  final String discountText;
  final String continueLabel;
  final VoidCallback onStartWorkPressed;

  const OnboardingStartBody({
    super.key,
    required this.discountText,
    required this.continueLabel,
    required this.onStartWorkPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;
    final discountStyle = textStyle.copyWith(
      color: CupertinoColors.secondaryLabel.resolveFrom(context),
    );

    return Padding(
      padding: const EdgeInsets.all(OnboardingLayout.screenPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              discountText,
              style: discountStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: OnboardingLayout.contentSpacing),
            CupertinoButton.filled(
              onPressed: onStartWorkPressed,
              child: Text(continueLabel),
            ),
          ],
        ),
      ),
    );
  }
}
