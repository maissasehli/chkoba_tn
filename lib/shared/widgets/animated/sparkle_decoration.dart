import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/constants/app_colors.dart';

class SparkleDecoration extends StatelessWidget {
  final AnimationController animationController;
  final double top;
  final double? left;
  final double? right;
  final double? bottom;
  final double size;
  final IconData icon;

  const SparkleDecoration({
    Key? key,
    required this.animationController,
    required this.top,
    this.left,
    this.right,
    this.bottom,
    required this.size,
    this.icon = Icons.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + 0.3 * math.sin(animationController.value * 2 * math.pi),
            child: Icon(
              icon,
              color: AppColors.goldOpacity(0.3),
              size: size,
            ),
          );
        },
      ),
    );
  }
}