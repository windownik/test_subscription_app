import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';
import 'package:test_payment_app/features/subscription/presentation/widgets/subscription_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listenWhen: (previous, current) =>
          previous.paymentProcessStatus != current.paymentProcessStatus,
      listener: onSubscriptionStateChanged,
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
            buildWhen: (previous, current) =>
                previous.selectedPlan != current.selectedPlan,
            builder: (context, state) {
              return SubscriptionBody(
                noSubscriptionText: l10n.noSubscription,
                monthlyPlanLabel: l10n.monthlyPlan,
                yearlyPlanLabel: l10n.yearlyPlan,
                isMonthlySelected:
                    state.selectedPlan == SubscriptionPlan.monthly,
                isYearlySelected:
                    state.selectedPlan == SubscriptionPlan.yearly,
                onMonthlyPlanPressed: () => onMonthlyPlanPressed(context),
                onYearlyPlanPressed: () => onYearlyPlanPressed(context),
                onContinuePressed: () => onContinuePressed(context),
              );
            },
          ),
        ),
      ),
    );
  }

  void onSubscriptionStateChanged(
    BuildContext context,
    SubscriptionState state,
  ) {
    switch (state.paymentProcessStatus) {
      case PaymentProcessStatus.success:
        unawaited(onPaymentSucceeded(context, state));
      case PaymentProcessStatus.error:
        showPaymentFailureDialog(context);
      case PaymentProcessStatus.noPaymentProcess:
      case PaymentProcessStatus.createOrder:
      case PaymentProcessStatus.checkMoney:
        return;
    }
  }

  Future<void> onPaymentSucceeded(
    BuildContext context,
    SubscriptionState state,
  ) async {
    await Future<void>.delayed(SubscriptionLayout.successNavigationDelay);

    if (!context.mounted) {
      return;
    }

    final plan = state.selectedPlan;
    if (plan == null) {
      return;
    }

    completeSubscription(context, plan);
  }

  void onMonthlyPlanPressed(BuildContext context) {
    context
        .read<SubscriptionBloc>()
        .add(const SubscriptionMonthlyPlanSelected());
  }

  void onYearlyPlanPressed(BuildContext context) {
    context.read<SubscriptionBloc>().add(const SubscriptionYearlyPlanSelected());
  }

  void onContinuePressed(BuildContext context) {
    context.read<SubscriptionBloc>().add(const SubscriptionPurchaseStarted());
  }

  void completeSubscription(BuildContext context, SubscriptionPlan plan) {
    context.read<AppBloc>().add(AppSubscriptionPlanSelected(plan));
  }

  void showPaymentFailureDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(l10n.paymentFailed),
        content: Text(l10n.paymentFailed),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => onPaymentFailureDialogClosed(context, dialogContext),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  void onPaymentFailureDialogClosed(
    BuildContext context,
    BuildContext dialogContext,
  ) {
    Navigator.of(dialogContext).pop();
    context.read<SubscriptionBloc>().add(const SubscriptionPaymentStatusReset());
  }
}
