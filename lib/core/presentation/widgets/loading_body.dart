import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/loading_layout.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({
    super.key,
    required this.appTitle,
  });

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final titleStyle = theme.textTheme.textStyle.copyWith(
      fontSize: LoadingLayout.titleFontSize,
      fontWeight: FontWeight.w600,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appTitle,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: LoadingLayout.titleLoaderSpacing),
          const CupertinoActivityIndicator(
            radius: LoadingLayout.activityIndicatorRadius,
          ),
        ],
      ),
    );
  }
}
