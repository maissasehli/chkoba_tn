import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales (thème tunisien)
  static const Color primaryRed = Color(0xFFE31E24);
  static const Color secondaryRed = Color(0xFFC41E3A);
  static const Color darkRed = Color(0xFF8B0000);
  static const Color gold = Color(0xFFFFD700);
  static const Color orange = Color(0xFFFFA500);
  
  // Couleurs système
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE31E24);
  static const Color warning = Color(0xFFFFA500);
  static const Color info = Color(0xFF2196F3);
  
  // Niveaux de blanc/noir
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey900 = Color(0xFF212121);
  
  // Couleurs avec opacité
  static Color whiteOpacity(double opacity) => white.withOpacity(opacity);
  static Color blackOpacity(double opacity) => black.withOpacity(opacity);
  static Color goldOpacity(double opacity) => gold.withOpacity(opacity);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryRed, secondaryRed, darkRed],
    stops: [0.0, 0.6, 1.0],
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, orange],
  );
  
  static const LinearGradient titleGradient = LinearGradient(
    colors: [white, gold, white],
    stops: [0.0, 0.5, 1.0],
  );
}
