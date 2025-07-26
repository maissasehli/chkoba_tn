// lib/features/auth/presentation/pages/login_page.dart
import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_strings.dart';
import 'package:chkoba_tn/features/auth/data/models/datasources/auth_remote_datasource.dart';
import 'package:chkoba_tn/features/auth/domain/entities/repositories/auth_repository.dart';
import 'package:chkoba_tn/features/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import '../../../data/models/datasources/auth_local_datasource.dart';
import '../../../data/models/repositories/auth_repository_impl.dart';
import '../../../domain/entities/usecases/guest_login_usecase.dart';
import '../../../domain/entities/usecases/social_login_usecase.dart';
import '../widgets/login_background.dart';
import '../widgets/login_logo.dart';
import '../widgets/login_card.dart';
import '../widgets/login_footer.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin {
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
    _controller.initialize(this);
    _controller.addListener(_onControllerUpdate);
  }

  void _initializeController() {
    // Injection de dépendances (dans un vrai projet, utilisez GetIt ou Provider)
    final remoteDataSource = AuthRemoteDataSourceImpl();
    final localDataSource = AuthLocalDataSourceImpl();
    final repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    
    final socialLoginUseCase = SocialLoginUseCase(repository as AuthRepository);
    final guestLoginUseCase = GuestLoginUseCase(repository as AuthRepository);
    
    _controller = LoginController(
      socialLoginUseCase: socialLoginUseCase,
      guestLoginUseCase: guestLoginUseCase,
    );
  }

  void _onControllerUpdate() {
    // Gérer la navigation après connexion réussie
    if (_controller.currentUser != null && !_controller.isLoading) {
      _showSuccessSnackBar();
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Navigation vers la page principale (à implémenter)
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  void _showSuccessSnackBar() {
    _showSnackBar(
      AppStrings.connectionSuccess,
      AppColors.success,
      Icons.check_circle_outline,
    );
  }

  void _showErrorSnackBar(String message) {
    _showSnackBar(
      message,
      AppColors.error,
      Icons.error_outline,
    );
  }

  void _showSnackBar(String message, Color color, IconData icon) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.white, size: 18),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(fontSize: 14)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleSocialLogin(String provider) async {
    try {
      await _controller.handleSocialLogin(provider);
    } catch (e) {
      _showErrorSnackBar(AppStrings.connectionError);
    }
  }

  void _handleGuestLogin() {
    _showErrorSnackBar(AppStrings.guestModeInDevelopment);
  }

  void _handleTermsTap() {
    _showErrorSnackBar(AppStrings.inDevelopment);
  }

  void _handlePrivacyTap() {
    _showErrorSnackBar(AppStrings.inDevelopment);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

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
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Éléments décoratifs de fond
              LoginBackground(
                shimmerController: _controller.shimmerController,
                cardController: _controller.cardController,
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
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _controller.fadeAnimation,
            child: SlideTransition(
              position: _controller.slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Section du haut - Logo et titre
                  SizedBox(
                    height: safeAreaHeight * 0.32,
                    child: Center(
                      child: LoginLogo(
                        cardController: _controller.cardController,
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
                    child: LoginCard(
                      controller: _controller,
                      safeAreaHeight: safeAreaHeight,
                      onSocialLogin: _handleSocialLogin,
                      onGuestLogin: _handleGuestLogin,
                    ),
                  ),
                  
                  // Section du bas - Conditions
                  SizedBox(
                    height: safeAreaHeight * 0.13,
                    child: Center(
                      child: LoginFooter(
                        onTermsTap: _handleTermsTap,
                        onPrivacyTap: _handlePrivacyTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}