import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundDecorationsWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final AnimationController? sparkleController;
  final AnimationController? cardController;

  const BackgroundDecorationsWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    this.sparkleController,
    this.cardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Étoile animée top-left
        if (sparkleController != null)
          Positioned(
            top: screenHeight * 0.08,
            left: screenWidth * 0.08,
            child: AnimatedBuilder(
              animation: sparkleController!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: sparkleController!.value * 2 * math.pi,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0x33FFD700),
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
        if (cardController != null)
          Positioned(
            top: screenHeight * 0.12,
            right: screenWidth * 0.06,
            child: AnimatedBuilder(
              animation: cardController!,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    3 * math.sin(cardController!.value * 2 * math.pi),
                    6 * math.sin(cardController!.value * 2 * math.pi + 1),
                  ),
                  child: Container(
                    width: 24,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0x33FFD700),
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
        if (sparkleController != null)
          Positioned(
            bottom: screenHeight * 0.1,
            left: screenWidth * 0.05,
            child: AnimatedBuilder(
              animation: sparkleController!,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + 0.08 * math.sin(sparkleController!.value * 2 * math.pi),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0x22FFD700),
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