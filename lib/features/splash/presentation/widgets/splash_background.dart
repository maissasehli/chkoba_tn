import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/animated/sparkle_decoration.dart';

class SplashBackground extends StatelessWidget {
  final AnimationController sparkleController;

  const SplashBackground({
    Key? key,
    required this.sparkleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Étoiles scintillantes
        SparkleDecoration(
          animationController: sparkleController,
          top: 60,
          left: 50,
          size: 25,
        ),
        
        SparkleDecoration(
          animationController: sparkleController,
          top: 100,
          right: 70,
          size: 20,
        ),
        
        SparkleDecoration(
          animationController: sparkleController,
          top: 0, // Add the required 'top' parameter, adjust value as needed
          bottom: 80,
          left: 80,
          size: 18,
        ),
        
        // Croissant décoratif rotatif
        Positioned(
          top: 80,
          right: 100,
          child: AnimatedBuilder(
            animation: sparkleController,
            builder: (context, child) {
              return Transform.rotate(
                angle: sparkleController.value * 2 * math.pi,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldOpacity(0.2),
                        offset: const Offset(6, 6),
                        blurRadius: 0,
                      ),
                    ],
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