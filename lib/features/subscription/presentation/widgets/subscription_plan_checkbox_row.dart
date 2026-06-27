import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';

class SubscriptionPlanCheckboxRow extends StatelessWidget {
  final String label;
  final String? priceText;
  final String? discountText;
  final bool isSelected;
  final VoidCallback onPressed;

  const SubscriptionPlanCheckboxRow({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.priceText,
    this.discountText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final textStyle = theme.textTheme.textStyle;
    final priceStyle = textStyle.copyWith(
      fontSize: SubscriptionLayout.planPriceFontSize,
      color: CupertinoColors.secondaryLabel.resolveFrom(context),
    );
    final discountStyle = textStyle.copyWith(
      fontSize: SubscriptionLayout.planDiscountFontSize,
      color: theme.primaryColor,
    );
    final activeColor = theme.primaryColor;
    final inactiveColor = CupertinoColors.systemGrey.resolveFrom(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textStyle,
                ),
                if (priceText != null) ...[
                  const SizedBox(height: SubscriptionLayout.planPriceTopSpacing),
                  Text(
                    priceText!,
                    style: priceStyle,
                  ),
                ],
                if (discountText != null) ...[
                  const SizedBox(
                    height: SubscriptionLayout.planDiscountTopSpacing,
                  ),
                  Text(
                    discountText!,
                    style: discountStyle,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
