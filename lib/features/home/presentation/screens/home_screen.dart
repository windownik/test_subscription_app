import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/home/presentation/widgets/home_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: HomeBody(mainScreenText: l10n.mainScreen),
      ),
    );
  }
}
