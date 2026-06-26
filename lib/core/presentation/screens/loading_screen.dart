import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/widgets/loading_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: LoadingBody(appTitle: l10n.payApp),
      ),
    );
  }
}
