import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/features/subscription/domain/entities/tariff_plans.dart';

abstract interface class TariffPlansRepository {
  Future<Either<Failure, TariffPlans>> getTariffPlans();
}
