import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/presentation/widgets/bottom_toast_notification_layout.dart';

class BottomToastNotification extends StatefulWidget {
  final String text;
  final VoidCallback onDisplayTimeReset;
  final ValueChanged<Future<void> Function()>? onDismissReady;

  const BottomToastNotification({
    super.key,
    required this.text,
    required this.onDisplayTimeReset,
    this.onDismissReady,
  });

  @override
  State<BottomToastNotification> createState() =>
      _BottomToastNotificationState();
}

class _BottomToastNotificationState extends State<BottomToastNotification>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: BottomToastNotificationLayout.slideAnimationDuration,
    );
    _slideAnimation = Tween<double>(
      begin: BottomToastNotificationLayout.slideDistance,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _animationController.forward();
    widget.onDismissReady?.call(dismiss);
  }

  @override
  void didUpdateWidget(BottomToastNotification oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      widget.onDisplayTimeReset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> dismiss() async {
    if (!mounted) {
      return;
    }

    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: child,
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width -
              BottomToastNotificationLayout.horizontalInset * 2,
        ),
        child: IntrinsicWidth(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.darkColor,
              borderRadius: BorderRadius.circular(
                BottomToastNotificationLayout.borderRadius,
              ),
            ),
            child: SizedBox(
              height: BottomToastNotificationLayout.toastHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: BottomToastNotificationLayout.horizontalPadding,
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.textStyle.copyWith(
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
