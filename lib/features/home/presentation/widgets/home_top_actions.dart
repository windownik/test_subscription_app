import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/widgets/circular_icon_button.dart';
import 'package:test_payment_app/features/home/presentation/home_layout.dart';

class HomeTopActions extends StatelessWidget {
  final String languageSymbol;
  final VoidCallback onReloadPressed;
  final VoidCallback onLanguagePressed;

  const HomeTopActions({
    super.key,
    required this.languageSymbol,
    required this.onReloadPressed,
    required this.onLanguagePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textStyle = CupertinoTheme.of(
      context,
    ).textTheme.textStyle.copyWith(fontWeight: FontWeight.w600);
    final iconColor = CupertinoTheme.of(context).textTheme.textStyle.color;

    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularIconButton(
            size: HomeLayout.actionButtonSize,
            padding: HomeLayout.actionButtonPadding,
            onTap: onReloadPressed,
            child: Icon(
              CupertinoIcons.arrow_clockwise,
              size: HomeLayout.actionButtonIconSize,
              color: iconColor,
            ),
          ),
          const Spacer(),
          CircularIconButton(
            size: HomeLayout.actionButtonSize,
            padding: HomeLayout.actionButtonPadding,
            onTap: onLanguagePressed,
            child: Text(languageSymbol, style: textStyle),
          ),
        ],
      ),
    );
  }
}
