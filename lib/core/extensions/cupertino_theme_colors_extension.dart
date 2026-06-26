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
}
