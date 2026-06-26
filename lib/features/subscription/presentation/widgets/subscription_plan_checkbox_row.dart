import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';

class SubscriptionPlanCheckboxRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const SubscriptionPlanCheckboxRow({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final textStyle = theme.textTheme.textStyle;
    final activeColor = theme.primaryColor;
    final inactiveColor = CupertinoColors.systemGrey.resolveFrom(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            isSelected
                ? CupertinoIcons.checkmark_square_fill
                : CupertinoIcons.square,
            size: SubscriptionLayout.checkboxIconSize,
            color: isSelected ? activeColor : inactiveColor,
          ),
          const SizedBox(width: SubscriptionLayout.checkboxLabelSpacing),
          Expanded(
            child: Text(
              label,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
