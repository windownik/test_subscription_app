import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';

abstract interface class OnboardingRepository {
  Stream<bool> watchOnboardingCompleted();

  Future<Either<Failure, void>> setOnboardingCompleted({
    required bool completed,
  });
}
