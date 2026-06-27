import 'package:test_payment_app/features/subscription/data/datasources/tariff_plans_remote_data_source.dart';
import 'package:test_payment_app/features/subscription/data/models/tariff_plans_dto.dart';
import 'package:test_payment_app/features/subscription/data/tariff_plans_api_layout.dart';

class TariffPlansRemoteDataSourceImpl implements TariffPlansRemoteDataSource {
  const TariffPlansRemoteDataSourceImpl();

  @override
  Future<TariffPlansDto> fetchTariffPlans() async {
    await Future<void>.delayed(TariffPlansApiLayout.requestDelay);

    return const TariffPlansDto(
      monthlyPriceCents: 500,
      yearlyPriceCents: 4800,
      yearlyDiscountPercent: 20,
      currency: 'USD',
    );
  }
}
