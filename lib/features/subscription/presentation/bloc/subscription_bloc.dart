import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:test_payment_app/features/subscription/presentation/bloc/subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc({
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        super(
          const SubscriptionState(
            selectedPlan: null,
            paymentProcessStatus: PaymentProcessStatus.noPaymentProcess,
          ),
        ) {
    on<SubscriptionMonthlyPlanSelected>(_onMonthlyPlanSelected);
    on<SubscriptionYearlyPlanSelected>(_onYearlyPlanSelected);
    on<SubscriptionPurchaseStarted>(_onPurchaseStarted);
    on<SubscriptionPaymentStatusReset>(_onPaymentStatusReset);
  }

  final PaymentRepository _paymentRepository;

  void _onMonthlyPlanSelected(
    SubscriptionMonthlyPlanSelected event,
    Emitter<SubscriptionState> emit,
  ) {
    if (!state.isPlanSelectionEnabled) {
      return;
    }

    emit(state.copyWith(selectedPlan: SubscriptionPlan.monthly));
  }

  void _onYearlyPlanSelected(
    SubscriptionYearlyPlanSelected event,
    Emitter<SubscriptionState> emit,
  ) {
    if (!state.isPlanSelectionEnabled) {
      return;
    }

    emit(state.copyWith(selectedPlan: SubscriptionPlan.yearly));
  }

  Future<void> _onPurchaseStarted(
    SubscriptionPurchaseStarted event,
    Emitter<SubscriptionState> emit,
  ) async {
    final plan = state.selectedPlan;
    if (plan == null || !state.isContinueEnabled) {
      return;
    }

    await emit.forEach(
      _paymentRepository.purchasePlan(plan),
      onData: (status) => state.copyWith(paymentProcessStatus: status),
      onError: (_, _) => state.copyWith(
        paymentProcessStatus: PaymentProcessStatus.error,
      ),
    );
  }

  void _onPaymentStatusReset(
    SubscriptionPaymentStatusReset event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(
      state.copyWith(
        paymentProcessStatus: PaymentProcessStatus.noPaymentProcess,
      ),
    );
  }
}
