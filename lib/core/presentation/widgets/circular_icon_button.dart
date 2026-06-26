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
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = widget.isActive && _isPressed
        ? CircularIconButton.pressedScale
        : 1.0;

    return GestureDetector(
      onTap: widget.isActive ? widget.onTap : null,
      onTapDown: widget.isActive ? (_) => onTapDown() : null,
      onTapUp: widget.isActive ? (_) => onTapUp() : null,
      onTapCancel: widget.isActive ? onTapCancel : null,
      child: AnimatedContainer(
        duration: CircularIconButton.pressAnimationDuration,
        curve: Curves.easeInOut,
        width: widget.size * scale,
        height: widget.size * scale,
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
              offset: const Offset(
                0,
                CircularIconButton.shadowOffsetY,
              ),
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

  void onTapDown() {
    setState(() => _isPressed = true);
  }

  void onTapUp() {
    setState(() => _isPressed = false);
  }

  void onTapCancel() {
    setState(() => _isPressed = false);
  }
}
