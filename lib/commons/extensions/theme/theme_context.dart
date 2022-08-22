import 'package:flutter/material.dart';

extension ContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  void showSnackBar({
    required String title,
    String buttonLabel = 'OK',
    VoidCallback? onPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: buttonLabel,
        onPressed: onPressed ?? () {},
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
