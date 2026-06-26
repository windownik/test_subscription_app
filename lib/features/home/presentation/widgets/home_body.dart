import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/home/presentation/home_layout.dart';
import 'package:test_payment_app/features/home/presentation/widgets/home_top_actions.dart';

class HomeBody extends StatelessWidget {
  final String mainScreenText;
  final String? selectedPlanText;
  final String languageSymbol;
  final VoidCallback onReloadPressed;
  final VoidCallback onLanguagePressed;

  const HomeBody({
    super.key,
    required this.mainScreenText,
    required this.languageSymbol,
    required this.onReloadPressed,
    required this.onLanguagePressed,
    this.selectedPlanText,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return Padding(
      padding: const EdgeInsets.all(HomeLayout.screenPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: HomeLayout.topActionsTopSpacing),
            HomeTopActions(
              languageSymbol: languageSymbol,
              onReloadPressed: onReloadPressed,
              onLanguagePressed: onLanguagePressed,
            ),
            const Spacer(flex: HomeLayout.contentTopSpacerFlex),
            Text(
              mainScreenText,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            if (selectedPlanText != null) ...[
              const SizedBox(height: HomeLayout.contentSpacing),
              Text(
                selectedPlanText!,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ],
            const Spacer(flex: HomeLayout.contentBottomSpacerFlex),
          ],
        ),
      ),
    );
  }
}
