import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/animated/animated_card.dart';

class SplashAnimatedCards extends StatelessWidget {
  final AnimationController cardController;
  final bool isCompact;

  const SplashAnimatedCards({
    Key? key,
    required this.cardController,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = isCompact ? AppDimensions.cardWidthCompact : AppDimensions.cardWidth;
    final cardHeight = isCompact ? AppDimensions.cardHeightCompact : AppDimensions.cardHeight;
    final containerWidth = isCompact ? 120.0 : 140.0;
    final containerHeight = isCompact ? 140.0 : 180.0;
    final fontSize = isCompact ? 24.0 : 28.0;
    
    return SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carte arrière
          AnimatedCard(
            isBack: true,
            width: cardWidth,
            height: cardHeight,
            fontSize: fontSize,
            animationController: cardController,
            animationOffset: 0,
            rotationOffset: -12,
          ),
          
          // Carte du milieu
          AnimatedCard(
            symbol: AppStrings.diamondSymbol,
            symbolColor: AppColors.primaryRed,
            width: cardWidth,
            height: cardHeight,
            fontSize: fontSize,
            animationController: cardController,
            animationOffset: 1,
            rotationOffset: -4,
          ),
          
          // Carte de devant
          AnimatedCard(
            symbol: AppStrings.heartSymbol,
            symbolColor: AppColors.primaryRed,
            width: cardWidth,
            height: cardHeight,
            fontSize: fontSize,
            animationController: cardController,
            animationOffset: 2,
            rotationOffset: 4,
          ),
        ],
      ),
    );
  }
}