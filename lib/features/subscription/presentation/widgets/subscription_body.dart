import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';

class SubscriptionBody extends StatelessWidget {
  final String noSubscriptionText;
  final String monthlyPlanLabel;
  final String yearlyPlanLabel;
  final VoidCallback onMonthlyPlanPressed;
  final VoidCallback onYearlyPlanPressed;

  const SubscriptionBody({
    super.key,
    required this.noSubscriptionText,
    required this.monthlyPlanLabel,
    required this.yearlyPlanLabel,
    required this.onMonthlyPlanPressed,
    required this.onYearlyPlanPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return Padding(
      padding: const EdgeInsets.all(SubscriptionLayout.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            noSubscriptionText,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SubscriptionLayout.contentSpacing),
          CupertinoButton.filled(
            onPressed: onMonthlyPlanPressed,
            child: Text(monthlyPlanLabel),
          ),
          const SizedBox(height: SubscriptionLayout.planButtonSpacing),
          CupertinoButton.filled(
            onPressed: onYearlyPlanPressed,
            child: Text(yearlyPlanLabel),
          ),
        ],
      ),
    );
  }
}
