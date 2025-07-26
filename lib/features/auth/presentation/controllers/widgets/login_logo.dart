import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_dimensions.dart';
import 'package:chkoba_tn/core/constants/app_strings.dart';
import 'package:chkoba_tn/shared/widgets/animated/gradient_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class LoginLogo extends StatelessWidget {
  final AnimationController cardController;
  final double safeAreaHeight;

  const LoginLogo({
    Key? key,
    required this.cardController,
    required this.safeAreaHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoScale = (safeAreaHeight / 800).clamp(0.7, 1.2);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cartes animées adaptatives
        SizedBox(
          width: 60 * logoScale,
          height: 42 * logoScale,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildAnimatedMiniCard(
                symbol: AppStrings.heartSymbol,
                color: AppColors.primaryRed,
                scale: logoScale,
                animationOffset: 0,
                translationOffset: const Offset(-10, 0),
                rotationMultiplier: 0.08,
              ),
              _buildAnimatedMiniCard(
                symbol: AppStrings.diamondSymbol,
                color: AppColors.gold,
                scale: logoScale,
                animationOffset: 2,
                translationOffset: const Offset(10, 0),
                rotationMultiplier: -0.08,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 12 * logoScale),
        
        // Titre adaptatif
        GradientText(
          text: AppStrings.appName,
          style: TextStyle(
            fontSize: (32 * logoScale).clamp(24, 40),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            shadows: const [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 6,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 4 * logoScale),
        
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * logoScale,
            vertical: 3 * logoScale,
          ),
          decoration: BoxDecoration(
            color: AppColors.goldOpacity(0.15),
            borderRadius: BorderRadius.circular(AppDimensions.radius12),
            border: Border.all(
              color: AppColors.goldOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            AppStrings.traditionalGame,
            style: TextStyle(
              fontSize: (10 * logoScale).clamp(8, 12),
              color: AppColors.gold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedMiniCard({
    required String symbol,
    required Color color,
    required double scale,
    required double animationOffset,
    required Offset translationOffset,
    required double rotationMultiplier,
  }) {
    return AnimatedBuilder(
      animation: cardController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            translationOffset.dx + 2 * math.sin(cardController.value * 2 * math.pi + animationOffset),
            translationOffset.dy + 2 * math.sin(cardController.value * 2 * math.pi + animationOffset + 1),
          ),
          child: Transform.rotate(
            angle: rotationMultiplier * math.sin(cardController.value * 2 * math.pi),
            child: Container(
              width: 22 * scale,
              height: 30 * scale,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: (22 * scale * 0.6).clamp(10, 16),
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}