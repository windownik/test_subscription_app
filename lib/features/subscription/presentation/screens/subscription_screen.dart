import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/core/di/injection.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/core/presentation/bloc/app_bloc.dart';
import 'package:test_payment_app/core/presentation/bloc/app_event.dart';
import 'package:test_payment_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/presentation/widgets/subscription_body.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  SubscriptionPlan? _selectedPlan;
  bool _isPurchasing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: SubscriptionBody(
          noSubscriptionText: l10n.noSubscription,
          monthlyPlanLabel: l10n.monthlyPlan,
          yearlyPlanLabel: l10n.yearlyPlan,
          continueLabel: l10n.continueButton,
          isMonthlySelected: _selectedPlan == SubscriptionPlan.monthly,
          isYearlySelected: _selectedPlan == SubscriptionPlan.yearly,
          isContinueEnabled: _selectedPlan != null && !_isPurchasing,
          isPurchasing: _isPurchasing,
          onMonthlyPlanPressed: onMonthlyPlanPressed,
          onYearlyPlanPressed: onYearlyPlanPressed,
          onContinuePressed: () => onContinuePressed(context),
        ),
      ),
    );
  }

  void onMonthlyPlanPressed() {
    setState(() => _selectedPlan = SubscriptionPlan.monthly);
  }

  void onYearlyPlanPressed() {
    setState(() => _selectedPlan = SubscriptionPlan.yearly);
  }

  Future<void> onContinuePressed(BuildContext context) async {
    final plan = _selectedPlan;
    if (plan == null || _isPurchasing) {
      return;
    }

    setState(() => _isPurchasing = true);

    final result = await getIt<PaymentRepository>().purchasePlan(plan);

    if (!mounted) {
      return;
    }

    setState(() => _isPurchasing = false);

    result.fold(
      (failure) => showPaymentFailureDialog(context, failure),
      (_) => completeSubscription(context, plan),
    );
  }

  void completeSubscription(BuildContext context, SubscriptionPlan plan) {
    context.read<AppBloc>().add(const AppOnboardingCompleted());
    context.read<AppBloc>().add(AppSubscriptionPlanSelected(plan));
  }

  void showPaymentFailureDialog(BuildContext context, Failure failure) {
    final l10n = AppLocalizations.of(context)!;
    final message = switch (failure) {
      PaymentFailure(:final message) => message,
      _ => l10n.paymentFailed,
    };

    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(l10n.paymentFailed),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }
}
