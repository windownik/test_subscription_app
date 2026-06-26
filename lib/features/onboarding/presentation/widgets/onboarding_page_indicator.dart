import 'package:flutter/cupertino.dart';
import 'package:test_payment_app/features/onboarding/presentation/onboarding_layout.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final int pageCount;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPageIndex,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: OnboardingLayout.indicatorBottomPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          final isLast = index == pageCount - 1;

          return Padding(
            padding: EdgeInsets.only(
              right: isLast ? 0 : OnboardingLayout.indicatorDotSpacing,
            ),
            child: _OnboardingIndicatorDot(
              isActive: index == currentPageIndex,
            ),
          );
        }),
      ),
    );
  }
}

class _OnboardingIndicatorDot extends StatefulWidget {
  final bool isActive;

  const _OnboardingIndicatorDot({required this.isActive});

  @override
  State<_OnboardingIndicatorDot> createState() => _OnboardingIndicatorDotState();
}

class _OnboardingIndicatorDotState extends State<_OnboardingIndicatorDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _alphaAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: OnboardingLayout.indicatorColorAnimationDuration,
    );
    _alphaAnimation = Tween<double>(
      begin: OnboardingLayout.indicatorInactiveAlpha,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _syncAnimation(animate: widget.isActive);
  }

  @override
  void didUpdateWidget(_OnboardingIndicatorDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _syncAnimation(animate: true);
    }
  }

  void _syncAnimation({required bool animate}) {
    if (widget.isActive) {
      if (animate) {
        _controller.forward();
      } else {
        _controller.value = 1;
      }
      return;
    }

    if (animate) {
      _controller.reverse();
    } else {
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = CupertinoTheme.of(context).textTheme.textStyle.color;

    return AnimatedBuilder(
      animation: _alphaAnimation,
      builder: (context, child) {
        return Container(
          width: OnboardingLayout.indicatorDotSize,
          height: OnboardingLayout.indicatorDotSize,
          decoration: BoxDecoration(
            color: baseColor?.withValues(alpha: _alphaAnimation.value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
