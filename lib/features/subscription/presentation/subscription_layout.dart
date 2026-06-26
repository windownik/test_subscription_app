import 'package:flutter/cupertino.dart';

abstract final class SubscriptionLayout {
  static const double screenPadding = 24;
  static const double contentSpacing = 16;
  static const double planCheckboxSpacing = 12;
  static const double checkboxIconSize = 24;
  static const double checkboxLabelSpacing = 12;
  static const double continueButtonTopSpacing = 24;
  static const double continueButtonHeight = 50;
  static const double continueButtonBorderRadius = 12;
  static const Duration continueButtonColorAnimationDuration =
      Duration(milliseconds: 400);
  static const Duration successNavigationDelay = Duration(milliseconds: 1500);

  static const Color continueButtonBlueGradientStart = Color(0xFF5AC8FA);
  static const Color continueButtonBlueGradientEnd = Color(0xFF007AFF);
  static const Color continueButtonGreenGradientStart = Color(0xFFB8F5C8);
  static const Color continueButtonGreenGradientEnd = Color(0xFF34C759);
  static const Color continueButtonErrorGradientStart = Color(0xFFFF8A80);
  static const Color continueButtonErrorGradientEnd = Color(0xFFFF3B30);
  static const Color continueButtonLabelColorOnBlue = Color(0xFFFFFFFF);
  static const Color continueButtonLabelColorOnGreen = Color(0xFF1B5E20);
  static const Color continueButtonLabelColorOnError = Color(0xFFFFFFFF);
}
