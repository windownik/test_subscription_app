import 'package:test_payment_app/features/subscription/data/models/tariff_plans_dto.dart';

abstract interface class TariffPlansRemoteDataSource {
  Future<TariffPlansDto> fetchTariffPlans();
}
