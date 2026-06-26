import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/subscription/presentation/subscription_layout.dart';

class SubscriptionContinueButton extends StatefulWidget {
  static const Duration pressAnimationDuration = Duration(milliseconds: 150);
  static const double pressedScale = 0.96;
  static const double disabledOpacity = 0.4;

  final String label;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final Color labelColor;
  final bool isEnabled;
  final bool isDimmed;
  final VoidCallback onPressed;

  const SubscriptionContinueButton({
    super.key,
    required this.label,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.labelColor,
    required this.isEnabled,
    this.isDimmed = false,
    required this.onPressed,
  });

  @override
  State<SubscriptionContinueButton> createState() =>
      _SubscriptionContinueButtonState();
}

class _SubscriptionContinueButtonState extends State<SubscriptionContinueButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: SubscriptionContinueButton.pressAnimationDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: SubscriptionContinueButton.pressedScale,
    ).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.isEnabled;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: isInteractive ? _onTapDown : null,
      onTapUp: isInteractive ? _onTapUp : null,
      onTapCancel: isInteractive ? _onTapCancel : null,
      onTap: isInteractive ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedOpacity(
          opacity: widget.isDimmed
              ? SubscriptionContinueButton.disabledOpacity
              : 1,
          duration: SubscriptionContinueButton.pressAnimationDuration,
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: SubscriptionLayout.continueButtonColorAnimationDuration,
            curve: Curves.easeInOut,
            height: SubscriptionLayout.continueButtonHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.gradientStartColor,
                  widget.gradientEndColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(
                SubscriptionLayout.continueButtonBorderRadius,
              ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: SubscriptionLayout.continueButtonColorAnimationDuration,
              curve: Curves.easeInOut,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    color: widget.labelColor,
                    fontWeight: FontWeight.w600,
                  ),
              child: AnimatedSwitcher(
                duration: SubscriptionLayout.continueButtonColorAnimationDuration,
                child: Text(
                  widget.label,
                  key: ValueKey(widget.label),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _pressController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _pressController.reverse();
  }

  void _onTapCancel() {
    _pressController.reverse();
  }
}
