import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

class SubscriptionState {
  const SubscriptionState({
    required this.selectedPlan,
    required this.paymentProcessStatus,
  });

  final SubscriptionPlan? selectedPlan;
  final PaymentProcessStatus paymentProcessStatus;

  bool get isContinueEnabled =>
      selectedPlan != null && paymentProcessStatus.isIdle;

  bool get isPlanSelectionEnabled => paymentProcessStatus.isIdle;

  bool get isPaymentInProgress => paymentProcessStatus.isInProgress;

  SubscriptionState copyWith({
    SubscriptionPlan? selectedPlan,
    PaymentProcessStatus? paymentProcessStatus,
    bool clearSelectedPlan = false,
  }) {
    return SubscriptionState(
      selectedPlan:
          clearSelectedPlan ? null : (selectedPlan ?? this.selectedPlan),
      paymentProcessStatus: paymentProcessStatus ?? this.paymentProcessStatus,
    );
  }
}
