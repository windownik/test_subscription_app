import 'package:test_payment_app/features/subscription/domain/entities/tariff_plan.dart';

class TariffPlans {
  const TariffPlans({
    required this.monthly,
    required this.yearly,
    required this.currency,
  });

  final TariffPlan monthly;
  final TariffPlan yearly;
  final String currency;
}
