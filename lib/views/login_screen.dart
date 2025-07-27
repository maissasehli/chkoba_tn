import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login/login_card_widget.dart';
import '../widgets/login/animated_logo_widget.dart';
import '../widgets/common/background_decorations_widget.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final safeAreaHeight = screenHeight - 
        MediaQuery.of(context).padding.top - 
        MediaQuery.of(context).padding.bottom;
    
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE31E24),
              Color(0xFFC41E3A),
              Color(0xFF8B0000),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Éléments décoratifs de fond
              BackgroundDecorationsWidget(
                screenWidth: screenWidth,
                screenHeight: safeAreaHeight,
              ),
              
              // Contenu principal
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: safeAreaHeight,
                  ),
                  child: _buildMainContent(safeAreaHeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(double safeAreaHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Section du haut - Logo et titre
          SizedBox(
            height: safeAreaHeight * 0.32,
            child: Center(
              child: AnimatedLogoWidget(
                safeAreaHeight: safeAreaHeight,
              ),
            ),
          ),
          
          // Section du milieu - Carte de connexion
          Container(
            constraints: BoxConstraints(
              maxWidth: 380,
              maxHeight: safeAreaHeight * 0.55,
            ),
            child: LoginCardWidget(
              safeAreaHeight: safeAreaHeight,
            ),
          ),
          
          // Section du bas - Conditions
          SizedBox(
            height: safeAreaHeight * 0.13,
            child: Center(
              child: _buildFooter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'En continuant, vous acceptez nos',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => controller.showErrorMessage('En développement'),
              child: const Text(
                'Conditions',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' et ',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 10,
              ),
            ),
            InkWell(
              onTap: () => controller.showErrorMessage('En développement'),
              child: const Text(
                'Confidentialité',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}