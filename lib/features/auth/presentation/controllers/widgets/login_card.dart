import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_dimensions.dart';
import 'package:chkoba_tn/features/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'social_buttons_section.dart';
import 'login_footer.dart';

class LoginCard extends StatelessWidget {
  final LoginController controller;
  final double safeAreaHeight;
  final VoidCallback onGuestLogin;
  final Function(String) onSocialLogin;

  const LoginCard({
    Key? key,
    required this.controller,
    required this.safeAreaHeight,
    required this.onGuestLogin,
    required this.onSocialLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardScale = (safeAreaHeight / 800).clamp(0.8, 1.1);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * cardScale),
      decoration: BoxDecoration(
        color: AppColors.whiteOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radius16),
        border: Border.all(
          color: AppColors.whiteOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackOpacity(0.1),
            offset: const Offset(0, 8),
            blurRadius: 32,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Boutons sociaux
          SocialButtonsSection(
            controller: controller,
            scale: cardScale,
            onSocialLogin: onSocialLogin,
          ),
          
          SizedBox(height: 14 * cardScale),
          
          // Séparateur
          _buildDivider(),
          
          SizedBox(height: 10 * cardScale),
          
          // Bouton invité
          _buildGuestButton(cardScale),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.grey300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing8),
          child: Text(
            'OU',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.grey300,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestButton(double scale) {
    return SizedBox(
      width: double.infinity,
      height: (38 * scale).clamp(34, 42),
      child: TextButton(
        onPressed: controller.isLoading ? null : onGuestLogin,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radius8),
          ),
        ),
        child: Text(
          'Continuer en tant qu\'invité',
          style: TextStyle(
            fontSize: (17 * scale).clamp(15, 21),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}