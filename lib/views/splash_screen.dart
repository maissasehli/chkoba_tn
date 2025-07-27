import 'package:chkoba_tn/widgets/common/background_decorations_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../widgets/splash/animated_cards_widget.dart';
import '../widgets/splash/progress_bar_widget.dart';
import 'dart:math' as math;

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE31E24),
              Color(0xFFC41E3A),
              Color(0xFF8B0000),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Éléments décoratifs de fond
            BackgroundDecorationsWidget(
              sparkleController: controller.sparkleController,
              screenWidth: MediaQuery.of(context).size.width,
              screenHeight: MediaQuery.of(context).size.height,
            ),
            
            // Contenu principal
            SafeArea(
              child: Center(
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: controller.fadeController,
                    curve: Curves.easeOut,
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: controller.fadeController,
                      curve: Curves.easeOut,
                    )),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isCompact = constraints.maxHeight < 500;
                        
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(flex: 1),
                                  
                                  // Logo avec cartes animées
                                  AnimatedCardsWidget(
                                    cardController: controller.cardController,
                                    isCompact: isCompact,
                                  ),
                                  
                                  SizedBox(height: isCompact ? 20 : 30),
                                  
                                  // Titre principal
                                  _buildTitle(isCompact: isCompact),
                                  
                                  SizedBox(height: isCompact ? 8 : 12),
                                  
                                  // Sous-titre
                                  _buildSubtitle(isCompact: isCompact),
                                  
                                  SizedBox(height: isCompact ? 30 : 40),
                                  
                                  // Barre de progression
                                  ProgressBarWidget(
                                    progressController: controller.progressController,
                                  ),
                                  
                                  SizedBox(height: isCompact ? 12 : 16),
                                  
                                  // Texte de chargement
                                  Obx(() => AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      controller.loadingText.value,
                                      key: ValueKey(controller.loadingText.value),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isCompact ? 13 : 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )),
                                  
                                  const Spacer(flex: 1),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({bool isCompact = false}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFFFD700)],
      ).createShader(bounds),
      child: Text(
        'CHKOBA',
        style: TextStyle(
          fontSize: isCompact ? 36 : 42,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 8,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle({bool isCompact = false}) {
    return Text(
      'Jeu de Cartes Tunisien Traditionnel',
      style: TextStyle(
        fontSize: isCompact ? 12 : 14,
        color: const Color(0xFFFFD700),
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