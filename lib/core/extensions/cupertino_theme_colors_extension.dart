import 'package:flutter/cupertino.dart';

extension CupertinoThemeColorsExtension on BuildContext {
  Color get circularIconButtonBackground {
    final theme = CupertinoTheme.of(this);

    return theme.brightness == Brightness.light
        ? CupertinoColors.white
        : CupertinoColors.secondarySystemBackground;
  }

  Color get circularIconButtonShadow {
    return CupertinoColors.systemGrey
        .resolveFrom(this)
        .withValues(alpha: circularIconButtonShadowOpacity);
  }

  static const double circularIconButtonShadowOpacity = 0.25;
  static const double circularIconButtonInactiveOpacity = 0.4;

  Color resolveCircularIconButtonBackground({required bool isActive}) {
    final background = circularIconButtonBackground;

    if (isActive) {
      return background;
    }

    return background.withValues(alpha: circularIconButtonInactiveOpacity);
  }

  Color resolveCircularIconButtonShadow({required bool isActive}) {
    if (!isActive) {
      return CupertinoColors.transparent;
    }

    return circularIconButtonShadow;
  }
}
