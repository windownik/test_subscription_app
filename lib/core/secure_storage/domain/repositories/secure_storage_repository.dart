import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';

abstract interface class SecureStorageRepository {
  Stream<String?> watch(String key);

  Future<Either<Failure, void>> write({
    required String key,
    required String value,
  });

  Future<Either<Failure, void>> delete({required String key});
}
