import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavIcon extends StatelessWidget {
  final String icon;
  const NavIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final texColor = Theme.of(context).textTheme.bodyLarge!.color!;
    return SvgPicture.asset(
      icon,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(texColor, BlendMode.srcIn),
    );
  }
}
