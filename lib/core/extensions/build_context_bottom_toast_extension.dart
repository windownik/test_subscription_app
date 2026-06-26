import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/widgets/bottom_toast_notification_overlay.dart';

extension BuildContextBottomToastExtension on BuildContext {
  void showBottomToast(String text) {
    BottomToastNotificationOverlay.show(this, text: text);
  }
}
