class TariffPlan {
  const TariffPlan({
    required this.priceInCents,
    this.discountPercent,
  });

  final int priceInCents;
  final int? discountPercent;
}
