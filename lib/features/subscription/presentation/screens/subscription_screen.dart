import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/core/presentation/bloc/app_state.dart';
import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:test_payment_app/features/subscription/presentation/extensions/subscription_payment_status_style_extension.dart';
import 'package:test_payment_app/features/subscription/presentation/extensions/tariff_plans_formatting_extension.dart';
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
          child: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) {
              final previousTariffPlans = switch (previous) {
                AppStateLoaded(:final tariffPlans) => tariffPlans,
                _ => null,
              };
              final currentTariffPlans = switch (current) {
                AppStateLoaded(:final tariffPlans) => tariffPlans,
                _ => null,
              };

              return previousTariffPlans != currentTariffPlans;
            },
            builder: (context, appState) {
              final tariffPlans = switch (appState) {
                AppStateLoaded(:final tariffPlans) => tariffPlans,
                _ => null,
              };

              return BlocBuilder<SubscriptionBloc, SubscriptionState>(
                buildWhen: (previous, current) =>
                    previous.selectedPlan != current.selectedPlan ||
                    previous.paymentProcessStatus !=
                        current.paymentProcessStatus,
                builder: (context, state) {
                  final paymentStatus = state.paymentProcessStatus;
                  final buttonStyle = paymentStatus.buttonStyle;

                  return SubscriptionBody(
                    noSubscriptionText: l10n.noSubscription,
                    monthlyPlanLabel: l10n.monthlyPlan,
                    yearlyPlanLabel: l10n.yearlyPlan,
                    monthlyPriceText:
                        tariffPlans?.monthlyPriceLabel(l10n),
                    yearlyPriceText: tariffPlans?.yearlyPriceLabel(l10n),
                    yearlyDiscountText:
                        tariffPlans?.yearlyDiscountLabel(l10n),
                    isMonthlySelected:
                        state.selectedPlan == SubscriptionPlan.monthly,
                    isYearlySelected:
                        state.selectedPlan == SubscriptionPlan.yearly,
                    continueButtonLabel: paymentStatus.buttonLabel(l10n),
                    continueButtonBackgroundColor:
                        buttonStyle.backgroundColor,
                    continueButtonLabelColor: buttonStyle.label,
                    isContinueEnabled: state.isContinueEnabled,
                    isContinueDimmed:
                        state.selectedPlan == null && paymentStatus.isIdle,
                    onMonthlyPlanPressed: () => onMonthlyPlanPressed(context),
                    onYearlyPlanPressed: () => onYearlyPlanPressed(context),
                    onContinuePressed: () => onContinuePressed(context),
                  );
                },
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
