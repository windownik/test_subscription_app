import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/extensions/cupertino_theme_colors_extension.dart';

class CircularIconButton extends StatefulWidget {
  static const double defaultSize = 56;
  static const double defaultPadding = 16;
  static const double shadowBlurRadius = 8;
  static const double shadowOffsetY = 2;
  static const double pressedScale = 0.95;
  static const Duration pressAnimationDuration = Duration(milliseconds: 150);

  final Widget child;
  final double size;
  final double padding;
  final bool isActive;
  final VoidCallback onTap;

  const CircularIconButton({
    super.key,
    required this.child,
    required this.onTap,
    this.size = defaultSize,
    this.padding = defaultPadding,
    this.isActive = true,
  });

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.isActive ? widget.onTap : null,
      child: AnimatedContainer(
        duration: CircularIconButton.pressAnimationDuration,
        curve: Curves.easeInOut,
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: context.resolveCircularIconButtonBackground(
            isActive: widget.isActive,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.resolveCircularIconButtonShadow(
                isActive: widget.isActive,
              ),
              blurRadius: CircularIconButton.shadowBlurRadius,
              offset: const Offset(0, CircularIconButton.shadowOffsetY),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: widget.child,
        ),
      ),
    );
  }
}
