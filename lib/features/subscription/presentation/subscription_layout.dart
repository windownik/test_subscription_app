import 'package:flutter/cupertino.dart';

abstract final class SubscriptionLayout {
  static const double screenPadding = 24;
  static const double contentSpacing = 16;
  static const double planCheckboxSpacing = 12;
  static const double checkboxIconSize = 24;
  static const double checkboxLabelSpacing = 12;
  static const double planPriceTopSpacing = 4;
  static const double planDiscountTopSpacing = 2;
  static const double planPriceFontSize = 14;
  static const double planDiscountFontSize = 13;
  static const double continueButtonTopSpacing = 24;
  static const double continueButtonHeight = 50;
  static const double continueButtonBorderRadius = 12;
  static const Duration continueButtonColorAnimationDuration =
      Duration(milliseconds: 400);
  static const Duration successNavigationDelay = Duration(milliseconds: 1500);

  static const Color continueButtonBlueColor = Color(0xFF0062CC);
  static const Color continueButtonGreenColor = Color(0xFF34C759);
  static const Color continueButtonErrorColor = Color(0xFFFF3B30);
  static const Color continueButtonLabelColor = Color(0xFFFFFFFF);
}
