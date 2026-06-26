import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/core/locale/app_language.dart';
import 'package:test_payment_app/core/locale/domain/repositories/language_repository.dart';
import 'package:test_payment_app/core/secure_storage/domain/repositories/secure_storage_repository.dart';
import 'package:test_payment_app/core/secure_storage/domain/secure_storage_keys.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  const LanguageRepositoryImpl(this._secureStorageRepository);

  final SecureStorageRepository _secureStorageRepository;

  @override
  Stream<AppLanguage> watchLanguage() {
    return _secureStorageRepository
        .watch(SecureStorageKeys.appLanguage)
        .map(AppLanguage.fromStorageValue);
  }

  @override
  Future<Either<Failure, void>> setLanguage(AppLanguage language) {
    return _secureStorageRepository.write(
      key: SecureStorageKeys.appLanguage,
      value: language.storageValue,
    );
  }

  @override
  Future<Either<Failure, void>> clearLanguage() {
    return _secureStorageRepository.delete(
      key: SecureStorageKeys.appLanguage,
    );
  }
}
