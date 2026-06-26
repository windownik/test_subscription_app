enum SubscriptionPlan {
  monthly,
  yearly;

  String get storageValue => name;

  static SubscriptionPlan? fromStorageValue(String? value) {
    return switch (value) {
      'monthly' => SubscriptionPlan.monthly,
      'yearly' => SubscriptionPlan.yearly,
      _ => null,
    };
  }
}
