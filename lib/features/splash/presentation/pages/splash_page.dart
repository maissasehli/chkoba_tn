import 'package:flutter/material.dart';
import '../controllers/splash_controller.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_content.dart';
import '../../../../core/constants/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final SplashController _controller;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _controller = SplashController();
    _controller.initialize(this);
    _controller.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    // Navigation après completion de l'animation
    if (_controller.progressAnimation.isCompleted && !_hasNavigated) {
      _hasNavigated = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _controller.navigateToLogin(context);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Stack(
          children: [
            // Éléments décoratifs de fond
            SplashBackground(
              sparkleController: _controller.sparkleController,
            ),
            
            // Contenu principal
            SafeArea(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxHeight < 500;
                    
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: ListenableBuilder(
                            listenable: _controller,
                            builder: (context, child) {
                              return SplashContent(
                                fadeAnimation: _controller.fadeAnimation,
                                cardController: _controller.cardController,
                                progressController: _controller.progressController,
                                loadingText: _controller.loadingText,
                                isCompact: isCompact,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}