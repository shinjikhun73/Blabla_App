import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null
          ? Icon(icon, color: isPrimary ? BlaColors.white : BlaColors.primary)
          : SizedBox.shrink(),

      label: Text(
        label,
        style: BlaTextStyles.button.copyWith(
          color: isPrimary ? BlaColors.white : BlaColors.primary,
        ),
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 80,
          vertical: 16,
        ), // it's optional to use or just use size bok
      ),
      onPressed: onPressed,
    );
  }
}
