import 'package:awesome_board_v2/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DimmedButton extends StatelessWidget {
  const DimmedButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.color,
    this.backgroundColor,
    this.icon,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final Color? backgroundColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        icon: icon!,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.secondBackground,
          foregroundColor: color ?? AppTheme.primary,
        ),
        label: child,
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppTheme.secondBackground,
        foregroundColor: color ?? AppTheme.primary,
      ),
      child: child,
    );
  }
}
