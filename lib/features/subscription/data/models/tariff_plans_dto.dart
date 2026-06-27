class TariffPlansDto {
  const TariffPlansDto({
    required this.monthlyPriceCents,
    required this.yearlyPriceCents,
    required this.yearlyDiscountPercent,
    required this.currency,
  });

  final int monthlyPriceCents;
  final int yearlyPriceCents;
  final int yearlyDiscountPercent;
  final String currency;
}
