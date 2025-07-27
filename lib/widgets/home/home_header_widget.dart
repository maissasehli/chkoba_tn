import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeHeaderWidget extends StatelessWidget {
  final AnimationController cardController;

  const HomeHeaderWidget({
    Key? key,
    required this.cardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo avec cartes animées
          SizedBox(
            width: 80,
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: cardController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        -15 + 3 * math.sin(cardController.value * 2 * math.pi),
                        2 * math.sin(cardController.value * 2 * math.pi + 1),
                      ),
                      child: Transform.rotate(
                        angle: 0.1 * math.sin(cardController.value * 2 * math.pi),
                        child: _buildMiniCard('♥', const Color(0xFFE31E24), 28, 40),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: cardController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        15 + 3 * math.sin(cardController.value * 2 * math.pi + 2),
                        2 * math.sin(cardController.value * 2 * math.pi + 3),
                      ),
                      child: Transform.rotate(
                        angle: -0.1 * math.sin(cardController.value * 2 * math.pi),
                        child: _buildMiniCard('♦', const Color(0xFFFFD700), 28, 40),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Titre
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFFFFD700)],
            ).createShader(bounds),
            child: const Text(
              'CHKOBA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard(String symbol, Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: width * 0.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
