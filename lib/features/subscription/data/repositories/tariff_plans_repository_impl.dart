import 'package:fpdart/fpdart.dart';
import 'package:test_payment_app/core/error/failure.dart';
import 'package:test_payment_app/features/subscription/data/datasources/tariff_plans_remote_data_source.dart';
import 'package:test_payment_app/features/subscription/domain/entities/tariff_plan.dart';
import 'package:test_payment_app/features/subscription/domain/entities/tariff_plans.dart';
import 'package:test_payment_app/features/subscription/domain/repositories/tariff_plans_repository.dart';

class TariffPlansRepositoryImpl implements TariffPlansRepository {
  const TariffPlansRepositoryImpl(this._remoteDataSource);

  final TariffPlansRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, TariffPlans>> getTariffPlans() async {
    try {
      final dto = await _remoteDataSource.fetchTariffPlans();

      return Right(
        TariffPlans(
          monthly: TariffPlan(priceInCents: dto.monthlyPriceCents),
          yearly: TariffPlan(
            priceInCents: dto.yearlyPriceCents,
            discountPercent: dto.yearlyDiscountPercent,
          ),
          currency: dto.currency,
        ),
      );
    } on Exception catch (error) {
      return Left(TariffPlansFailure(error.toString()));
    }
  }
}
