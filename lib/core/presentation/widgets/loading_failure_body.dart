import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/loading_layout.dart';

class LoadingFailureBody extends StatelessWidget {
  const LoadingFailureBody({
    super.key,
    required this.appTitle,
    required this.errorMessage,
    required this.retryLabel,
    required this.onRetryPressed,
  });

  final String appTitle;
  final String errorMessage;
  final String retryLabel;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final titleStyle = theme.textTheme.textStyle.copyWith(
      fontSize: LoadingLayout.titleFontSize,
      fontWeight: FontWeight.w600,
    );
    final messageStyle = theme.textTheme.textStyle.copyWith(
      fontSize: theme.textTheme.textStyle.fontSize,
    );

    return Padding(
      padding: const EdgeInsets.all(LoadingLayout.failureScreenPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appTitle,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LoadingLayout.failureIconSpacing),
            Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: LoadingLayout.failureIconSize,
              color: theme.primaryColor,
            ),
            const SizedBox(height: LoadingLayout.failureMessageSpacing),
            Text(
              errorMessage,
              style: messageStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LoadingLayout.failureMessageSpacing),
            CupertinoButton.filled(
              onPressed: onRetryPressed,
              child: Text(retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
