import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

typedef SubscriptionContinueButtonGradient = ({
  Color start,
  Color end,
  Color label,
});

extension SubscriptionPaymentStatusStyle on PaymentProcessStatus {
  String buttonLabel(AppLocalizations l10n) {
    return switch (this) {
      PaymentProcessStatus.noPaymentProcess => l10n.continueButton,
      PaymentProcessStatus.createOrder => l10n.paymentCreateOrder,
      PaymentProcessStatus.checkMoney => l10n.paymentCheckMoney,
      PaymentProcessStatus.success => l10n.paymentSuccess,
      PaymentProcessStatus.error => l10n.paymentError,
    };
  }

  SubscriptionContinueButtonGradient get buttonGradient {
    if (this == PaymentProcessStatus.error) {
      return (
        start: SubscriptionLayout.continueButtonErrorGradientStart,
        end: SubscriptionLayout.continueButtonErrorGradientEnd,
        label: SubscriptionLayout.continueButtonLabelColorOnError,
      );
    }

    final progress = _successProgress;
    final start = Color.lerp(
      SubscriptionLayout.continueButtonBlueGradientStart,
      SubscriptionLayout.continueButtonGreenGradientStart,
      progress,
    )!;
    final end = Color.lerp(
      SubscriptionLayout.continueButtonBlueGradientEnd,
      SubscriptionLayout.continueButtonGreenGradientEnd,
      progress,
    )!;
    final label = Color.lerp(
      SubscriptionLayout.continueButtonLabelColorOnBlue,
      SubscriptionLayout.continueButtonLabelColorOnGreen,
      progress,
    )!;

    return (start: start, end: end, label: label);
  }

  double get _successProgress {
    return switch (this) {
      PaymentProcessStatus.noPaymentProcess => 0,
      PaymentProcessStatus.createOrder => 0.35,
      PaymentProcessStatus.checkMoney => 0.7,
      PaymentProcessStatus.success => 1,
      PaymentProcessStatus.error => 0,
    };
  }
}
