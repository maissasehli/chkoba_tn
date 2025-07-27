import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCardsWidget extends StatelessWidget {
  final AnimationController cardController;
  final bool isCompact;

  const AnimatedCardsWidget({
    Key? key,
    required this.cardController,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = isCompact ? 70 : 85;
    double cardHeight = isCompact ? 105 : 130;
    double containerWidth = isCompact ? 120 : 140;
    double containerHeight = isCompact ? 140 : 180;
    
    return SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carte arrière (plus sombre pour l'ombre)
          AnimatedBuilder(
            animation: cardController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -12,
                  3 * math.sin(cardController.value * 2 * math.pi) - 6,
                ),
                child: Transform.rotate(
                  angle: -0.15 + 0.03 * math.sin(cardController.value * 2 * math.pi),
                  child: _buildRealisticCard(
                    isBack: true, 
                    width: cardWidth, 
                    height: cardHeight
                  ),
                ),
              );
            },
          ),
          
          // Carte du milieu
          AnimatedBuilder(
            animation: cardController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -4,
                  4 * math.sin(cardController.value * 2 * math.pi + 1) - 3,
                ),
                child: Transform.rotate(
                  angle: -0.05 + 0.03 * math.sin(cardController.value * 2 * math.pi + 1),
                  child: _buildRealisticCard(
                    symbol: '♦', 
                    symbolColor: const Color(0xFFE31E24),
                    width: cardWidth, 
                    height: cardHeight,
                    fontSize: isCompact ? 24 : 28,
                  ),
                ),
              );
            },
          ),
          
          // Carte de devant (avec cœur)
          AnimatedBuilder(
            animation: cardController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  4,
                  5 * math.sin(cardController.value * 2 * math.pi + 2),
                ),
                child: Transform.rotate(
                  angle: 0.08 + 0.03 * math.sin(cardController.value * 2 * math.pi + 2),
                  child: _buildRealisticCard(
                    symbol: '♥', 
                    symbolColor: const Color(0xFFE31E24),
                    width: cardWidth, 
                    height: cardHeight,
                    fontSize: isCompact ? 24 : 28,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRealisticCard({
    String? symbol, 
    Color? symbolColor, 
    bool isBack = false,
    double width = 85,
    double height = 130,
    double fontSize = 28,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isBack ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Ombre principale
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          // Ombre secondaire pour plus de profondeur
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: isBack ? Colors.grey.shade200 : Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: isBack 
        ? Container()
        : Center(
            child: symbol != null 
              ? Text(
                  symbol,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: symbolColor ?? Colors.black,
                  ),
                ) 
              : Container(),
          ),
    );
  }
}