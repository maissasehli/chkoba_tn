import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_durations.dart';

class SplashLoadingText extends StatelessWidget {
  final String loadingText;
  final bool isCompact;

  const SplashLoadingText({
    Key? key,
    required this.loadingText,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppDurations.quick,
      child: Text(
        loadingText,
        key: ValueKey(loadingText),
        style: TextStyle(
          color: AppColors.white,
          fontSize: isCompact ? 13 : 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}