import 'package:chkoba_tn/shared/widgets/animated/loading/custom_progress_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/animated/gradient_text.dart';
import 'splash_animated_cards.dart';
import 'splash_loading_text.dart';

class SplashContent extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final AnimationController cardController;
  final AnimationController progressController;
  final String loadingText;
  final bool isCompact;

  const SplashContent({
    Key? key,
    required this.fadeAnimation,
    required this.cardController,
    required this.progressController,
    required this.loadingText,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(fadeAnimation),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            
            // Logo avec cartes animées
            SplashAnimatedCards(
              cardController: cardController,
              isCompact: isCompact,
            ),
            
            SizedBox(height: isCompact ? 20 : 30),
            
            // Titre principal
            _buildTitle(isCompact),
            
            SizedBox(height: isCompact ? 8 : 12),
            
            // Sous-titre
            _buildSubtitle(isCompact),
            
            SizedBox(height: isCompact ? 30 : 40),
            
            // Barre de progression
            CustomProgressBar(
              animationController: progressController,
            ),
            
            SizedBox(height: isCompact ? 12 : 16),
            
            // Texte de chargement
            SplashLoadingText(
              loadingText: loadingText,
              isCompact: isCompact,
            ),
            
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(bool isCompact) {
    return GradientText(
      text: AppStrings.appName,
      style: TextStyle(
        fontSize: isCompact ? 36 : 42,
        fontWeight: FontWeight.bold,
        shadows: const [
          Shadow(
            offset: Offset(2, 2),
            blurRadius: 8,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(bool isCompact) {
    return Text(
      AppStrings.appSubtitle,
      style: TextStyle(
        fontSize: isCompact ? 12 : 14,
        color: AppColors.gold,
        fontWeight: FontWeight.w500,
        shadows: const [
          Shadow(
            offset: Offset(1, 1),
            blurRadius: 4,
            color: Colors.black54,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}