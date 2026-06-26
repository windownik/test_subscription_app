import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/core/extensions/cupertino_theme_colors_extension.dart';
import 'package:test_payment_app/core/presentation/circular_icon_button_layout.dart';

class CircularIconButton extends StatefulWidget {
  final Widget child;
  final double size;
  final double padding;
  final VoidCallback onTap;

  const CircularIconButton({
    super.key,
    required this.child,
    required this.size,
    required this.padding,
    required this.onTap,
  });

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed
        ? CircularIconButtonLayout.pressedScale
        : 1.0;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTapUp(),
      onTapCancel: onTapCancel,
      child: AnimatedContainer(
        duration: CircularIconButtonLayout.pressAnimationDuration,
        curve: Curves.easeInOut,
        width: widget.size * scale,
        height: widget.size * scale,
        decoration: BoxDecoration(
          color: context.circularIconButtonBackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.circularIconButtonShadow,
              blurRadius: CircularIconButtonLayout.shadowBlurRadius,
              offset: const Offset(
                0,
                CircularIconButtonLayout.shadowOffsetY,
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
