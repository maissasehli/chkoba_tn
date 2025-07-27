import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/home/home_header_widget.dart';
import '../widgets/home/page_indicators_widget.dart';
import '../widgets/home/game_modes_widget.dart';
import '../widgets/home/profile_section_widget.dart';
import '../widgets/home/settings_section_widget.dart';
import '../widgets/home/stats_section_widget.dart';
import '../widgets/common/background_decorations_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
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
                screenWidth: screenSize.width,
                screenHeight: screenSize.height,
                sparkleController: controller.sparkleController,
                cardController: controller.cardController,
              ),
              
              // Contenu principal
              AnimatedBuilder(
                animation: controller.fadeController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: controller.fadeController,
                      curve: Curves.easeOut,
                    ),
                    child: isLandscape 
                      ? _buildLandscapeLayout(screenSize)
                      : _buildPortraitLayout(screenSize),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(Size screenSize) {
    final safeHeight = screenSize.height - 
        MediaQuery.of(Get.context!).padding.top - 
        MediaQuery.of(Get.context!).padding.bottom;
    
    return Column(
      children: [
        // Header avec logo - 20% de la hauteur
        SizedBox(
          height: safeHeight * 0.2,
          child: HomeHeaderWidget(
            cardController: controller.cardController,
          ),
        ),
        
        // Section des pages avec indicateurs - 60% de la hauteur
        SizedBox(
          height: safeHeight * 0.6,
          child: Column(
            children: [
              // Indicateurs de page
              PageIndicatorsWidget(
                currentPage: controller.currentPage,
                onPageChanged: controller.changePage,
              ),
              const SizedBox(height: 8),
              // Contenu scrollable
              Expanded(child: _buildScrollableContent(isPortrait: true)),
            ],
          ),
        ),
        
        // Section du bas avec statistiques - 20% de la hauteur
        SizedBox(
          height: safeHeight * 0.2,
          child: StatsSectionWidget(
            gameStats: controller.gameStats,
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Colonne gauche avec logo et stats - 28% de la largeur
          Expanded(
            flex: 28,
            child: Column(
              children: [
                Expanded(
                  flex: 3, 
                  child: HomeHeaderWidget(
                    cardController: controller.cardController,
                  ),
                ),
                Expanded(
                  flex: 2, 
                  child: StatsSectionWidget(
                    gameStats: controller.gameStats,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Colonne droite avec contenu scrollable - 72% de la largeur
          Expanded(
            flex: 72,
            child: Column(
              children: [
                PageIndicatorsWidget(
                  currentPage: controller.currentPage,
                  onPageChanged: controller.changePage,
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildScrollableContent(isPortrait: false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent({required bool isPortrait}) {
    return PageView(
      onPageChanged: controller.changePage,
      children: [
        GameModesWidget(
          isPortrait: isPortrait,
          onQuickGame: controller.startQuickGame,
          onMultiplayer: controller.startMultiplayer,
          onTournament: controller.startTournament,
          onTutorial: controller.startTutorial,
          pulseController: controller.pulseController,
        ),
        ProfileSectionWidget(
          isPortrait: isPortrait,
          gameStats: controller.gameStats,
        ),
        SettingsSectionWidget(
          isPortrait: isPortrait,
          onFeatureTap: controller.showFeatureInDevelopment,
          onSignOut: () => Get.find<AuthController>().signOut(),
        ),
      ],
    );
  }
}