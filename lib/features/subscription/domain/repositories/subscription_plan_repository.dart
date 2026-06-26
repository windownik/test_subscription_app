import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';

abstract interface class SubscriptionPlanRepository {
  Stream<SubscriptionPlan?> watchSelectedPlan();

  Future<Either<Failure, void>> selectPlan(SubscriptionPlan plan);

  Future<Either<Failure, void>> clearSelectedPlan();
}
