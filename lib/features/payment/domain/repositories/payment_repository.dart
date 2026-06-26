import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

abstract interface class PaymentRepository {
  Stream<PaymentProcessStatus> purchasePlan(SubscriptionPlan plan);
}
