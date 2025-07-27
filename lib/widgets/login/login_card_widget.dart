import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class LoginCardWidget extends GetView<AuthController> {
  final double safeAreaHeight;

  const LoginCardWidget({
    Key? key,
    required this.safeAreaHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardScale = (safeAreaHeight / 800).clamp(0.8, 1.1);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * cardScale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
          _buildSocialButtons(cardScale),
          
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

  Widget _buildSocialButtons(double scale) {
    final buttonHeight = (44 * scale).clamp(40, 50);
    
    return Obx(() => Column(
      children: [
        // Facebook
        SizedBox(
          width: double.infinity,
          height: buttonHeight.toDouble(),
          child: ElevatedButton.icon(
            onPressed: (controller.isLoading.value && controller.loadingProvider.value != 'Facebook') 
                ? null 
                : controller.signInWithFacebook,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1877F2),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: controller.isLoading.value && controller.loadingProvider.value == 'Facebook'
                ? SizedBox(
                    width: 16 * scale,
                    height: 16 * scale,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(Icons.facebook, size: 18 * scale),
            label: Text(
              controller.isLoading.value && controller.loadingProvider.value == 'Facebook' 
                  ? 'Connexion...' 
                  : 'Facebook',
              style: TextStyle(
                fontSize: (18 * scale).clamp(16, 22),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 10 * scale),
        
        // Google
        SizedBox(
          width: double.infinity,
          height: buttonHeight.toDouble(),
          child: OutlinedButton.icon(
            onPressed: (controller.isLoading.value && controller.loadingProvider.value != 'Google') 
                ? null 
                : controller.signInWithGoogle,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1A1A1A),
              side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: controller.isLoading.value && controller.loadingProvider.value == 'Google'
                ? SizedBox(
                    width: 16 * scale,
                    height: 16 * scale,
                    child: const CircularProgressIndicator(
                      color: Color(0xFF1A1A1A),
                      strokeWidth: 2,
                    ),
                  )
                : Container(
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
                          color: Colors.white,
                          fontSize: (10 * scale).clamp(8, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            label: Text(
              controller.isLoading.value && controller.loadingProvider.value == 'Google' 
                  ? 'Connexion...' 
                  : 'Google',
              style: TextStyle(
                fontSize: (18 * scale).clamp(16, 22),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OU',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestButton(double scale) {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: (38 * scale).clamp(34, 42),
      child: TextButton(
        onPressed: controller.isLoading.value ? null : controller.signInAsGuest,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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
    ));
  }
}