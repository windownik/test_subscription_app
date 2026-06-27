import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/payment/domain/entities/payment_process_status.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';
import 'package:test_payment_app/l10n/app_localizations.dart';

typedef SubscriptionContinueButtonStyle = ({
  Color backgroundColor,
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

  SubscriptionContinueButtonStyle get buttonStyle {
    if (this == PaymentProcessStatus.error) {
      return (
        backgroundColor: SubscriptionLayout.continueButtonErrorColor,
        label: SubscriptionLayout.continueButtonLabelColor,
      );
    }

    final progress = _successProgress;
    final backgroundColor = Color.lerp(
      SubscriptionLayout.continueButtonBlueColor,
      SubscriptionLayout.continueButtonGreenColor,
      progress,
    )!;

    return (
      backgroundColor: backgroundColor,
      label: SubscriptionLayout.continueButtonLabelColor,
    );
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
