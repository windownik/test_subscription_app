import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/core/secure_storage/domain/repositories/secure_storage_repository.dart';
import 'package:test_payment_app/core/secure_storage/domain/secure_storage_keys.dart';
import 'package:test_payment_app/features/subscription/domain/entities/subscription_plan.dart';
import 'package:test_payment_app/features/subscription/domain/repositories/subscription_plan_repository.dart';

class SubscriptionPlanRepositoryImpl implements SubscriptionPlanRepository {
  const SubscriptionPlanRepositoryImpl(this._secureStorageRepository);

  final SecureStorageRepository _secureStorageRepository;

  @override
  Stream<SubscriptionPlan?> watchSelectedPlan() {
    return _secureStorageRepository
        .watch(SecureStorageKeys.subscriptionPlan)
        .map(SubscriptionPlan.fromStorageValue);
  }

  @override
  Future<Either<Failure, void>> selectPlan(SubscriptionPlan plan) {
    return _secureStorageRepository.write(
      key: SecureStorageKeys.subscriptionPlan,
      value: plan.storageValue,
    );
  }
}
