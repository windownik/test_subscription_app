import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/core/secure_storage/data/datasources/secure_storage_local_data_source.dart';
import 'package:test_payment_app/core/secure_storage/domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  const SecureStorageRepositoryImpl(this._localDataSource);

  final SecureStorageLocalDataSource _localDataSource;

  @override
  Stream<String?> watch(String key) => _localDataSource.watch(key);

  @override
  Future<Either<Failure, void>> write({
    required String key,
    required String value,
  }) async {
    try {
      await _localDataSource.write(key: key, value: value);
      return const Right(null);
    } on PlatformException catch (error) {
      return Left(SecureStorageFailure(error.message ?? error.code));
    } catch (error) {
      return Left(SecureStorageFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete({required String key}) async {
    try {
      await _localDataSource.delete(key: key);
      return const Right(null);
    } on PlatformException catch (error) {
      return Left(SecureStorageFailure(error.message ?? error.code));
    } catch (error) {
      return Left(SecureStorageFailure(error.toString()));
    }
  }
}
