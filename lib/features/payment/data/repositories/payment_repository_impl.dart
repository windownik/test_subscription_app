import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl();

  static const Duration _purchaseDelay = Duration(milliseconds: 600);

  @override
  Future<Either<Failure, void>> purchasePlan(SubscriptionPlan plan) async {
    await Future<void>.delayed(_purchaseDelay);
    return const Right(null);
  }
}
