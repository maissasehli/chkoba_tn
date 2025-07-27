import 'package:flutter/material.dart' ;
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  // Observables
  final RxString loadingText = 'Mélange des cartes...'.obs;
  
  // Animation Controllers
  late AnimationController fadeController;
  late AnimationController cardController;
  late AnimationController progressController;
  late AnimationController sparkleController;

  final List<String> loadingMessages = [
    'Mélange des cartes...',
    'Préparation du jeu...',
    'Bienvenue dans Chkoba!'
  ];

  @override
  void onInit() {
    super.onInit();
    _setLandscapeOrientation();
    _initAnimations();
    _startLoadingSequence();
  }

  @override
  void onClose() {
    fadeController.dispose();
    cardController.dispose();
    progressController.dispose();
    sparkleController.dispose();
    super.onClose();
  }

  void _setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _initAnimations() {
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    cardController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    sparkleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  void _startLoadingSequence() {
    fadeController.forward();
    cardController.repeat();
    sparkleController.repeat();
    
    progressController.addListener(() {
      if (progressController.value > 0.3 && loadingText.value == loadingMessages[0]) {
        loadingText.value = loadingMessages[1];
      } else if (progressController.value > 0.7 && loadingText.value == loadingMessages[1]) {
        loadingText.value = loadingMessages[2];
      }
    });
    
    progressController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offNamed('/login');
      });
    });
  }
}