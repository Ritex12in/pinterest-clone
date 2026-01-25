import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double height;
  final double width;

  const SquareIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.height = 52,
    this.width = 52,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        color: textColor?.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Icon(icon),
        ),
      ),
    );
  }
}