import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/widgets/bottom_toast_notification.dart';
import 'package:test_payment_app/core/presentation/widgets/bottom_toast_notification_layout.dart';

class BottomToastNotificationOverlay {
  BottomToastNotificationOverlay._();

  static OverlayEntry? _overlayEntry;
  static Timer? _dismissTimer;
  static _BottomToastOverlayHostState? _hostState;
  static bool _isDismissing = false;

  static void show(BuildContext context, {required String text}) {
    final overlayState = _resolveOverlayState(context);
    if (overlayState == null) {
      return;
    }

    _showInOverlay(overlayState, text: text);
  }

  static OverlayState? _resolveOverlayState(BuildContext context) {
    if (context is StatefulElement) {
      final state = context.state;
      if (state is NavigatorState && state.mounted) {
        return state.overlay;
      }
    }

    final navigatorState = context.findAncestorStateOfType<NavigatorState>();
    if (navigatorState != null) {
      return navigatorState.overlay;
    }

    return Overlay.maybeOf(context, rootOverlay: true);
  }

  static void _showInOverlay(OverlayState overlayState, {required String text}) {
    if (_overlayEntry != null) {
      _hostState?.updateText(text);
      _resetDisplayTimer();
      return;
    }

    _isDismissing = false;

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return _BottomToastOverlayHost(
          initialText: text,
          onDisplayTimeReset: _resetDisplayTimer,
          onStateCreated: (state) => _hostState = state,
        );
      },
    );

    overlayState.insert(_overlayEntry!);
    _resetDisplayTimer();
  }

  static void _resetDisplayTimer() {
    _dismissTimer?.cancel();
    _dismissTimer = Timer(
      BottomToastNotificationLayout.displayDuration,
      _dismiss,
    );
  }

  static Future<void> _dismiss() async {
    if (_isDismissing || _overlayEntry == null) {
      return;
    }

    _isDismissing = true;
    _dismissTimer?.cancel();
    _dismissTimer = null;

    await _hostState?.dismiss();

    _overlayEntry?.remove();
    _overlayEntry = null;
    _hostState = null;
    _isDismissing = false;
  }
}

class _BottomToastOverlayHost extends StatefulWidget {
  final String initialText;
  final VoidCallback onDisplayTimeReset;
  final ValueChanged<_BottomToastOverlayHostState> onStateCreated;

  const _BottomToastOverlayHost({
    required this.initialText,
    required this.onDisplayTimeReset,
    required this.onStateCreated,
  });

  @override
  State<_BottomToastOverlayHost> createState() =>
      _BottomToastOverlayHostState();
}

class _BottomToastOverlayHostState extends State<_BottomToastOverlayHost> {
  late String _text;
  Future<void> Function()? _dismissNotification;

  @override
  void initState() {
    super.initState();
    _text = widget.initialText;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStateCreated(this);
    });
  }

  void updateText(String text) {
    setState(() => _text = text);
  }

  Future<void> dismiss() async {
    final dismissNotification = _dismissNotification;
    if (dismissNotification != null) {
      await dismissNotification();
    }
  }

  void onDismissReady(Future<void> Function() dismiss) {
    _dismissNotification = dismiss;
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomPadding + BottomToastNotificationLayout.bottomOffset,
      child: Center(
        child: BottomToastNotification(
          text: _text,
          onDisplayTimeReset: widget.onDisplayTimeReset,
          onDismissReady: onDismissReady,
        ),
      ),
    );
  }
}
