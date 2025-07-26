import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';


class CustomProgressBar extends StatelessWidget {
  final AnimationController animationController;
  final double width;
  final double height;

  const CustomProgressBar({
    Key? key,
    required this.animationController,
    this.width = AppDimensions.progressBarWidth,
    this.height = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.whiteOpacity(0.3),
          borderRadius: BorderRadius.circular(AppDimensions.radius10),
        ),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: animationController.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(AppDimensions.radius10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}