import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:test_payment_app/features/payment/payment_layout.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl();

  @override
  Stream<PaymentProcessStatus> purchasePlan(SubscriptionPlan plan) async* {
    yield PaymentProcessStatus.createOrder;
    await Future<void>.delayed(PaymentLayout.purchaseStepDelay);

    yield PaymentProcessStatus.checkMoney;
    await Future<void>.delayed(PaymentLayout.purchaseStepDelay);

    yield PaymentProcessStatus.success;
  }
}
