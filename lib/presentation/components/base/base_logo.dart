import 'package:adaptive_sizer/adaptive_sizer.dart';
import 'package:flutter/material.dart';

class BaseLogo extends StatelessWidget {
  const BaseLogo({
    super.key,
    this.isSmall = false,
  });

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/launcher.png',
      height: isSmall ? null : 100.h,
      width: isSmall ? 68.w : null,
      fit: BoxFit.cover,
    );
  }
}
