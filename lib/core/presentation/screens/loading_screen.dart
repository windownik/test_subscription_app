import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/core/presentation/widgets/loading_body.dart';
import 'package:test_payment_app/core/presentation/widgets/loading_failure_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            return switch (state) {
              AppStateFailure() => LoadingFailureBody(
                  appTitle: l10n.payApp,
                  errorMessage: l10n.loadingError,
                  retryLabel: l10n.retry,
                  onRetryPressed: () => onRetryPressed(context),
                ),
              _ => LoadingBody(appTitle: l10n.payApp),
            };
          },
        ),
      ),
    );
  }

  void onRetryPressed(BuildContext context) {
    context.read<AppBloc>().add(const AppRetryPressed());
  }
}
