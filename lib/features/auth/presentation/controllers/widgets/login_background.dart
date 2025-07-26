import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoginBackground extends StatelessWidget {
  final AnimationController shimmerController;
  final AnimationController cardController;
  final double screenWidth;
  final double screenHeight;

  const LoginBackground({
    Key? key,
    required this.shimmerController,
    required this.cardController,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Étoile animée top-left
        Positioned(
          top: screenHeight * 0.08,
          left: screenWidth * 0.08,
          child: AnimatedBuilder(
            animation: shimmerController,
            builder: (context, child) {
              return Transform.rotate(
                angle: shimmerController.value * 2 * math.pi,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Color(0x33FFD700),
                        Colors.transparent,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Color(0x55FFD700),
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ),
        
        // Carte flottante top-right
        Positioned(
          top: screenHeight * 0.12,
          right: screenWidth * 0.06,
          child: AnimatedBuilder(
            animation: cardController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  3 * math.sin(cardController.value * 2 * math.pi),
                  6 * math.sin(cardController.value * 2 * math.pi + 1),
                ),
                child: Container(
                  width: 24,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.whiteOpacity(0.12),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.goldOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '♠',
                      style: TextStyle(
                        color: Color(0x77FFD700),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        // Cercle bottom-left
        Positioned(
          bottom: screenHeight * 0.1,
          left: screenWidth * 0.05,
          child: AnimatedBuilder(
            animation: shimmerController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1 + 0.08 * math.sin(shimmerController.value * 2 * math.pi),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Color(0x22FFD700),
                        Colors.transparent,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}