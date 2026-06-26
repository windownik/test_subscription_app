import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/core/secure_storage/domain/repositories/secure_storage_repository.dart';
import 'package:test_payment_app/core/secure_storage/domain/secure_storage_keys.dart';
import 'package:test_payment_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._secureStorageRepository);

  final SecureStorageRepository _secureStorageRepository;

  static const String _completedValue = 'true';
  static const String _notCompletedValue = 'false';

  @override
  Stream<bool> watchOnboardingCompleted() {
    return _secureStorageRepository
        .watch(SecureStorageKeys.onboardingCompleted)
        .map((value) => value == _completedValue);
  }

  @override
  Future<Either<Failure, void>> setOnboardingCompleted({
    required bool completed,
  }) {
    return _secureStorageRepository.write(
      key: SecureStorageKeys.onboardingCompleted,
      value: completed ? _completedValue : _notCompletedValue,
    );
  }

  @override
  Future<Either<Failure, void>> clearOnboardingData() {
    return _secureStorageRepository.delete(
      key: SecureStorageKeys.onboardingCompleted,
    );
  }
}
