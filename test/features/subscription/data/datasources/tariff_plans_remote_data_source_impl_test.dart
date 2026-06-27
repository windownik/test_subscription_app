import 'package:flutter_test/flutter_test.dart';
import 'package:test_payment_app/features/subscription/data/datasources/tariff_plans_remote_data_source_impl.dart';
import 'package:test_payment_app/features/subscription/data/models/tariff_plans_dto.dart';
import 'package:test_payment_app/features/subscription/data/tariff_plans_api_layout.dart';

void main() {
  late TariffPlansRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = const TariffPlansRemoteDataSourceImpl();
  });

  group('TariffPlansRemoteDataSourceImpl', () {
    test('fetchTariffPlans returns expected tariff plans dto', () async {
      final result = await dataSource.fetchTariffPlans();

      expect(
        result,
        const TariffPlansDto(
          monthlyPriceCents: 500,
          yearlyPriceCents: 4800,
          yearlyDiscountPercent: 20,
          currency: 'USD',
        ),
      );
    });

    test('fetchTariffPlans waits at least request delay', () async {
      final stopwatch = Stopwatch()..start();

      await dataSource.fetchTariffPlans();

      expect(
        stopwatch.elapsed,
        greaterThanOrEqualTo(TariffPlansApiLayout.requestDelay),
      );
    });
  });
}
