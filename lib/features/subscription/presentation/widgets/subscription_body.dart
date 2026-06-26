import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';
import 'package:test_payment_app/features/subscription/presentation/widgets/subscription_continue_button_stream.dart';
import 'package:test_payment_app/features/subscription/presentation/widgets/subscription_plan_checkbox_row.dart';

class SubscriptionBody extends StatelessWidget {
  final String noSubscriptionText;
  final String monthlyPlanLabel;
  final String yearlyPlanLabel;
  final bool isMonthlySelected;
  final bool isYearlySelected;
  final VoidCallback onMonthlyPlanPressed;
  final VoidCallback onYearlyPlanPressed;
  final VoidCallback onContinuePressed;

  const SubscriptionBody({
    super.key,
    required this.noSubscriptionText,
    required this.monthlyPlanLabel,
    required this.yearlyPlanLabel,
    required this.isMonthlySelected,
    required this.isYearlySelected,
    required this.onMonthlyPlanPressed,
    required this.onYearlyPlanPressed,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return Padding(
      padding: const EdgeInsets.all(SubscriptionLayout.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
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
                SubscriptionPlanCheckboxRow(
                  label: monthlyPlanLabel,
                  isSelected: isMonthlySelected,
                  onPressed: onMonthlyPlanPressed,
                ),
                const SizedBox(height: SubscriptionLayout.planCheckboxSpacing),
                SubscriptionPlanCheckboxRow(
                  label: yearlyPlanLabel,
                  isSelected: isYearlySelected,
                  onPressed: onYearlyPlanPressed,
                ),
              ],
            ),
          ),
          const SizedBox(height: SubscriptionLayout.continueButtonTopSpacing),
          SubscriptionContinueButtonStream(
            onPressed: onContinuePressed,
          ),
        ],
      ),
    );
  }
}
