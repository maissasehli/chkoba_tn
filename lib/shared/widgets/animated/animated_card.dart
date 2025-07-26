import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';

class AnimatedCard extends StatelessWidget {
  final String? symbol;
  final Color? symbolColor;
  final bool isBack;
  final double width;
  final double height;
  final double fontSize;
  final AnimationController animationController;
  final double animationOffset;
  final double rotationOffset;

  const AnimatedCard({
    Key? key,
    this.symbol,
    this.symbolColor,
    this.isBack = false,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.animationController,
    this.animationOffset = 0,
    this.rotationOffset = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            rotationOffset + 2 * math.sin(animationController.value * 2 * math.pi + animationOffset),
            3 * math.sin(animationController.value * 2 * math.pi + animationOffset + 1),
          ),
          child: Transform.rotate(
            angle: (rotationOffset * 0.01) + 0.03 * math.sin(animationController.value * 2 * math.pi + animationOffset),
            child: _buildCard(),
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isBack ? AppColors.grey100 : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radius12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackOpacity(0.25),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.blackOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: isBack ? AppColors.grey200 : AppColors.grey100,
          width: 1,
        ),
      ),
      child: isBack 
        ? const SizedBox.shrink()
        : Center(
            child: symbol != null 
              ? Text(
                  symbol!,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: symbolColor ?? AppColors.black,
                  ),
                ) 
              : const SizedBox.shrink(),
          ),
    );
  }
}