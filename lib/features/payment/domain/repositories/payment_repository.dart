import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

abstract interface class PaymentRepository {
  Future<Either<Failure, void>> purchasePlan(SubscriptionPlan plan);
}
