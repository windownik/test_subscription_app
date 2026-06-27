import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:test_payment_app/features/subscription/presentation/extensions/subscription_payment_status_style_extension.dart';
import 'package:test_payment_app/features/subscription/presentation/widgets/subscription_continue_button.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class SubscriptionContinueButtonStream extends StatelessWidget {
  final VoidCallback onPressed;

  const SubscriptionContinueButtonStream({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SubscriptionBloc>();
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<SubscriptionState>(
      stream: bloc.stream,
      initialData: bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? bloc.state;
        final status = state.paymentProcessStatus;
        final buttonStyle = status.buttonStyle;

        return SubscriptionContinueButton(
          label: status.buttonLabel(l10n),
          backgroundColor: buttonStyle.backgroundColor,
          labelColor: buttonStyle.label,
          isEnabled: state.isContinueEnabled,
          isDimmed:
              state.selectedPlan == null &&
              status.isIdle,
          onPressed: onPressed,
        );
      },
    );
  }
}
