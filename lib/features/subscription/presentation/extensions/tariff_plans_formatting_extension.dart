import 'package:intl/intl.dart';
import 'package:test_payment_app/features/subscription/domain/entities/tariff_plans.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

extension TariffPlansFormatting on TariffPlans {
  String monthlyPriceLabel(AppLocalizations l10n) {
    return l10n.planPricePerMonth(
      _formatPrice(monthly.priceInCents, currency),
    );
  }

  String yearlyPriceLabel(AppLocalizations l10n) {
    return l10n.planPricePerYear(
      _formatPrice(yearly.priceInCents, currency),
    );
  }

  String? yearlyDiscountLabel(AppLocalizations l10n) {
    final discountPercent = yearly.discountPercent;
    if (discountPercent == null) {
      return null;
    }

    return l10n.yearlyPlanDiscount(discountPercent);
  }

  String _formatPrice(int priceInCents, String currency) {
    final formatter = NumberFormat.simpleCurrency(name: currency);
    return formatter.format(priceInCents / 100);
  }
}
