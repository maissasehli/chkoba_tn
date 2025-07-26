import 'package:chkoba_tn/features/auth/domain/entities/usecases/guest_login_usecase.dart';
import 'package:chkoba_tn/features/auth/domain/entities/usecases/social_login_usecase.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/constants/app_strings.dart';

import '../../domain/entities/user.dart';

class LoginController with ChangeNotifier {
  final SocialLoginUseCase _socialLoginUseCase;
  final GuestLoginUseCase _guestLoginUseCase;

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _cardController;
  late AnimationController _shimmerController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _shimmerAnimation;

  bool _isLoading = false;
  String _loadingProvider = '';
  User? _currentUser;
  bool _isDisposed = false;

  LoginController({
    required SocialLoginUseCase socialLoginUseCase,
    required GuestLoginUseCase guestLoginUseCase,
  })  : _socialLoginUseCase = socialLoginUseCase,
        _guestLoginUseCase = guestLoginUseCase;

  // Animation getters
  Animation<Offset> get slideAnimation => _slideAnimation;
  Animation<double> get fadeAnimation => _fadeAnimation;
  Animation<double> get cardAnimation => _cardAnimation;
  Animation<double> get shimmerAnimation => _shimmerAnimation;
  
  // Controller getters (NEW - these were missing!)
  AnimationController get slideController => _slideController;
  AnimationController get fadeController => _fadeController;
  AnimationController get cardController => _cardController;
  AnimationController get shimmerController => _shimmerController;
  
  // State getters
  bool get isLoading => _isLoading;
  String get loadingProvider => _loadingProvider;
  User? get currentUser => _currentUser;

  void initialize(TickerProvider vsync) {
    _initializeControllers(vsync);
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeControllers(TickerProvider vsync) {
    _slideController = AnimationController(
      duration: AppDurations.slow,
      vsync: vsync,
    );

    _fadeController = AnimationController(
      duration: AppDurations.slower,
      vsync: vsync,
    );

    _cardController = AnimationController(
      duration: AppDurations.extraLong,
      vsync: vsync,
    );

    _shimmerController = AnimationController(
      duration: AppDurations.veryLong,
      vsync: vsync,
    );
  }

  void _initializeAnimations() {
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    );

    _shimmerAnimation = CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    );
  }

  void _startAnimations() {
    Future.delayed(AppDurations.quick, () {
      if (!_isDisposed) {
        _slideController.forward();
        _fadeController.forward();
      }
    });
    _cardController.repeat();
    _shimmerController.repeat();
  }

  Future<void> handleSocialLogin(String provider) async {
    if (_isDisposed) return;
    
    _setLoadingState(true, provider);

    try {
      User user;
      switch (provider.toLowerCase()) {
        case 'facebook':
          user = await _socialLoginUseCase.loginWithFacebook();
          break;
        case 'google':
          user = await _socialLoginUseCase.loginWithGoogle();
          break;
        default:
          throw Exception('Provider non supporté: $provider');
      }

      _currentUser = user;
      _notifySuccess();
    } catch (e) {
      _notifyError(e.toString());
    } finally {
      _setLoadingState(false, '');
    }
  }

  Future<void> handleGuestLogin() async {
    if (_isDisposed) return;
    
    _setLoadingState(true, 'guest');

    try {
      final user = await _guestLoginUseCase.loginAsGuest();
      _currentUser = user;
      _notifySuccess();
    } catch (e) {
      _notifyError(AppStrings.guestModeInDevelopment);
    } finally {
      _setLoadingState(false, '');
    }
  }

  void _setLoadingState(bool loading, String provider) {
    if (_isDisposed) return;
    _isLoading = loading;
    _loadingProvider = provider;
    notifyListeners();
  }

  void _notifySuccess() {
    if (_isDisposed) return;
    // Le widget parent écoutera les changements via notifyListeners()
    notifyListeners();
  }

  void _notifyError(String message) {
    if (_isDisposed) return;
    // Le widget parent gérera l'affichage des erreurs
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _slideController.dispose();
    _fadeController.dispose();
    _cardController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }
}