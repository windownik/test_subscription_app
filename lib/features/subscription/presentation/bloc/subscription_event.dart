sealed class SubscriptionEvent {
  const SubscriptionEvent();
}

final class SubscriptionMonthlyPlanSelected extends SubscriptionEvent {
  const SubscriptionMonthlyPlanSelected();
}

final class SubscriptionYearlyPlanSelected extends SubscriptionEvent {
  const SubscriptionYearlyPlanSelected();
}

final class SubscriptionPurchaseStarted extends SubscriptionEvent {
  const SubscriptionPurchaseStarted();
}

final class SubscriptionPaymentStatusReset extends SubscriptionEvent {
  const SubscriptionPaymentStatusReset();
}
