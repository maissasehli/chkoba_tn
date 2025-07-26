import 'package:chkoba_tn/features/auth/presentation/controllers/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/constants/app_strings.dart';

class SplashController with ChangeNotifier {
  late AnimationController _fadeController;
  late AnimationController _cardController;
  late AnimationController _progressController;
  late AnimationController _sparkleController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _sparkleAnimation;

  String _loadingText = AppStrings.shufflingCards;
  bool _isDisposed = false;

  final List<String> _loadingMessages = [
    AppStrings.shufflingCards,
    AppStrings.preparingGame,
    AppStrings.welcomeMessage,
  ];

  // Animation getters
  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<double> get cardAnimation => _cardAnimation;
  Animation<double> get progressAnimation => _progressAnimation;
  Animation<double> get sparkleAnimation => _sparkleAnimation;
  
  // Controller getters (NEW - these were missing!)
  AnimationController get fadeController => _fadeController;
  AnimationController get cardController => _cardController;
  AnimationController get progressController => _progressController;
  AnimationController get sparkleController => _sparkleController;
  
  String get loadingText => _loadingText;

  void initialize(TickerProvider vsync) {
    _forceOrientation();
    _initializeControllers(vsync);
    _initializeAnimations();
    _startAnimations();
  }

  void _forceOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _initializeControllers(TickerProvider vsync) {
    _fadeController = AnimationController(
      duration: AppDurations.slower,
      vsync: vsync,
    );
    
    _cardController = AnimationController(
      duration: AppDurations.veryLong,
      vsync: vsync,
    );
    
    _progressController = AnimationController(
      duration: AppDurations.extraLong,
      vsync: vsync,
    );
    
    _sparkleController = AnimationController(
      duration: AppDurations.long,
      vsync: vsync,
    );
  }

  void _initializeAnimations() {
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    
    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    );
    
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    );
    
    _sparkleAnimation = CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeInOut,
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    _cardController.repeat();
    _sparkleController.repeat();
    
    _progressController.addListener(_onProgressChanged);
    _progressController.forward().then(_onAnimationComplete);
  }

  void _onProgressChanged() {
    if (_isDisposed) return;
    
    if (_progressController.value > 0.3 && _loadingText == _loadingMessages[0]) {
      _updateLoadingText(_loadingMessages[1]);
    } else if (_progressController.value > 0.7 && _loadingText == _loadingMessages[1]) {
      _updateLoadingText(_loadingMessages[2]);
    }
  }

  void _updateLoadingText(String newText) {
    _loadingText = newText;
    notifyListeners();
  }

  void _onAnimationComplete(_) {
    if (_isDisposed) return;
    
    Future.delayed(AppDurations.navigationDelay, () {
      if (!_isDisposed) {
        // Navigation sera gérée par le widget parent
        notifyListeners();
      }
    });
  }

  void navigateToLogin(BuildContext context) {
    if (!_isDisposed) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const LoginPage())
      );
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _fadeController.dispose();
    _cardController.dispose();
    _progressController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }
}