import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_strings.dart';
import 'package:chkoba_tn/features/auth/presentation/controllers/login_controller.dart';
import 'package:chkoba_tn/shared/widgets/animated/buttons/social_login_button.dart';
import 'package:flutter/material.dart';


class SocialButtonsSection extends StatelessWidget {
  final LoginController controller;
  final double scale;
  final Function(String) onSocialLogin;

  const SocialButtonsSection({
    Key? key,
    required this.controller,
    required this.scale,
    required this.onSocialLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonHeight = (44 * scale).clamp(40, 50);
    
    return Column(
      children: [
        // Facebook Button
        SocialLoginButton(
          provider: 'Facebook',
          label: AppStrings.facebook,
          icon: const Icon(Icons.facebook, size: 18),
          onPressed: (controller.isLoading && controller.loadingProvider != 'Facebook')
              ? null
              : () => onSocialLogin('Facebook'),
          isLoading: controller.isLoading && controller.loadingProvider == 'Facebook',
          backgroundColor: const Color(0xFF1877F2),
          height: buttonHeight.toDouble(),
        ),
        
        SizedBox(height: 10 * scale),
        
        // Google Button
        SocialLoginButton(
          provider: 'Google',
          label: AppStrings.google,
          icon: _buildGoogleIcon(scale),
          onPressed: (controller.isLoading && controller.loadingProvider != 'Google')
              ? null
              : () => onSocialLogin('Google'),
          isLoading: controller.isLoading && controller.loadingProvider == 'Google',
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.grey900,
          isOutlined: true,
          height: buttonHeight.toDouble(),
        ),
      ],
    );
  }

  Widget _buildGoogleIcon(double scale) {
    return Container(
      width: 18 * scale,
      height: 18 * scale,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            color: AppColors.white,
            fontSize: (10 * scale).clamp(8, 12),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}