import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/home/presentation/home_layout.dart';

class HomeBody extends StatelessWidget {
  final String mainScreenText;

  const HomeBody({
    super.key,
    required this.mainScreenText,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return Padding(
      padding: const EdgeInsets.all(HomeLayout.screenPadding),
      child: Center(
        child: Text(
          mainScreenText,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
