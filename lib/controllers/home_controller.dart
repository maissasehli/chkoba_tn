import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/game_stats_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  // Observables
  final RxInt currentPage = 0.obs;
  final Rx<GameStatsModel> gameStats = GameStatsModel().obs;
  final RxBool isLoading = false.obs;

  // Animation Controllers
  late AnimationController fadeController;
  late AnimationController cardController;
  late AnimationController sparkleController;
  late AnimationController pulseController;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _loadGameStats();
  }

  @override
  void onClose() {
    fadeController.dispose();
    cardController.dispose();
    sparkleController.dispose();
    pulseController.dispose();
    super.onClose();
  }

  void _initAnimations() {
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    cardController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    sparkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start animations
    fadeController.forward();
    cardController.repeat();
    sparkleController.repeat();
    pulseController.repeat();
  }

  void _loadGameStats() {
    // TODO: Charger les statistiques depuis la base de données
    gameStats.value = GameStatsModel(
      gamesPlayed: 0,
      victories: 0,
      winRate: 0.0,
      bestScore: 0,
    );
  }

  void changePage(int index) {
    currentPage.value = index;
  }

  void showFeatureInDevelopment(String feature) {
    Get.snackbar(
      'Information',
      '$feature en développement',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1877F2),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void startQuickGame() {
    showFeatureInDevelopment('Partie rapide');
  }

  void startMultiplayer() {
    showFeatureInDevelopment('Multijoueur');
  }

  void startTournament() {
    showFeatureInDevelopment('Tournoi');
  }

  void startTutorial() {
    showFeatureInDevelopment('Tutoriel');
  }
}