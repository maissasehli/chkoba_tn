import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedLogoWidget extends StatefulWidget {
  final double safeAreaHeight;

  const AnimatedLogoWidget({
    Key? key,
    required this.safeAreaHeight,
  }) : super(key: key);

  @override
  State<AnimatedLogoWidget> createState() => _AnimatedLogoWidgetState();
}

class _AnimatedLogoWidgetState extends State<AnimatedLogoWidget>
    with TickerProviderStateMixin {
  late AnimationController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoScale = (widget.safeAreaHeight / 800).clamp(0.7, 1.2);
    
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
              AnimatedBuilder(
                animation: _cardController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      -10 + 2 * math.sin(_cardController.value * 2 * math.pi),
                      2 * math.sin(_cardController.value * 2 * math.pi + 1),
                    ),
                    child: Transform.rotate(
                      angle: 0.08 * math.sin(_cardController.value * 2 * math.pi),
                      child: _buildMiniCard('♥', const Color(0xFFE31E24), 22 * logoScale, 30 * logoScale),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _cardController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      10 + 2 * math.sin(_cardController.value * 2 * math.pi + 2),
                      2 * math.sin(_cardController.value * 2 * math.pi + 3),
                    ),
                    child: Transform.rotate(
                      angle: -0.08 * math.sin(_cardController.value * 2 * math.pi),
                      child: _buildMiniCard('♦', const Color(0xFFFFD700), 22 * logoScale, 30 * logoScale),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: 12 * logoScale),
        
        // Titre adaptatif
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFFFD700),
              Colors.white,
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            'CHKOBA',
            style: TextStyle(
              fontSize: (32 * logoScale).clamp(24, 40),
              fontWeight: FontWeight.w900,
              color: Colors.white,
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
        ),
        
        SizedBox(height: 4 * logoScale),
        
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10 * logoScale, vertical: 3 * logoScale),
          decoration: BoxDecoration(
            color: const Color(0x15FFD700),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0x33FFD700),
              width: 1,
            ),
          ),
          child: Text(
            'Jeu Traditionnel Tunisien',
            style: TextStyle(
              fontSize: (10 * logoScale).clamp(8, 12),
              color: const Color(0xFFFFD700),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniCard(String symbol, Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: (width * 0.6).clamp(10, 16),
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}