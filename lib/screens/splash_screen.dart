import 'package:chkoba_tn/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

// Import de la page de connexion
// import 'chkoba_login_page.dart'; // Décommentez cette ligne dans votre projet

class ChkobaSplashScreen extends StatefulWidget {
  const ChkobaSplashScreen({Key? key}) : super(key: key);

  @override
  State<ChkobaSplashScreen> createState() => _ChkobaSplashScreenState();
}

class _ChkobaSplashScreenState extends State<ChkobaSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _cardController;
  late AnimationController _progressController;
  late AnimationController _sparkleController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _sparkleAnimation;

  String _loadingText = 'Mélange des cartes...';
  final List<String> _loadingMessages = [
    'Mélange des cartes...',
    'Préparation du jeu...',
    'Bienvenue dans Chkoba!'
  ];

  @override
  void initState() {
    super.initState();
    
    // Animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _cardController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _sparkleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animations
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

    // Start animations
    _startAnimations();
  }

  void _startAnimations() {
    _fadeController.forward();
    _cardController.repeat();
    _sparkleController.repeat();
    
    // Progress animation with loading text updates
    _progressController.addListener(() {
      if (_progressController.value > 0.3 && _loadingText == _loadingMessages[0]) {
        setState(() {
          _loadingText = _loadingMessages[1];
        });
      } else if (_progressController.value > 0.7 && _loadingText == _loadingMessages[1]) {
        setState(() {
          _loadingText = _loadingMessages[2];
        });
      }
    });
    
    _progressController.forward().then((_) {
      // Navigate to login screen after animation completes
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const ChkobaLoginPage())
        );
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _cardController.dispose();
    _progressController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE31E24), // Rouge tunisien
              Color(0xFFC41E3A),
              Color(0xFF8B0000),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Éléments décoratifs de fond
            ..._buildBackgroundDecorations(),
            
            // Contenu principal
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_fadeAnimation),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo avec cartes animées
                      _buildAnimatedCards(),
                      
                      const SizedBox(height: 40),
                      
                      // Titre principal
                      _buildTitle(),
                      
                      const SizedBox(height: 15),
                      
                      // Sous-titre
                      _buildSubtitle(),
                      
                      const SizedBox(height: 60),
                      
                      // Barre de progression
                      _buildProgressBar(),
                      
                      const SizedBox(height: 20),
                      
                      // Texte de chargement
                      _buildLoadingText(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundDecorations() {
    return [
      // Étoiles scintillantes
      Positioned(
        top: 80,
        left: 50,
        child: AnimatedBuilder(
          animation: _sparkleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.3 * math.sin(_sparkleAnimation.value * 2 * math.pi),
              child: const Icon(
                Icons.star,
                color: Color(0x33FFD700),
                size: 30,
              ),
            );
          },
        ),
      ),
      
      Positioned(
        top: 150,
        right: 70,
        child: AnimatedBuilder(
          animation: _sparkleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.3 * math.sin(_sparkleAnimation.value * 2 * math.pi + 1),
              child: const Icon(
                Icons.star,
                color: Color(0x33FFD700),
                size: 25,
              ),
            );
          },
        ),
      ),
      
      Positioned(
        bottom: 200,
        left: 80,
        child: AnimatedBuilder(
          animation: _sparkleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.3 * math.sin(_sparkleAnimation.value * 2 * math.pi + 2),
              child: const Icon(
                Icons.star,
                color: Color(0x33FFD700),
                size: 20,
              ),
            );
          },
        ),
      ),
      
      // Croissant décoratif
      Positioned(
        top: 120,
        right: 100,
        child: AnimatedBuilder(
          animation: _sparkleController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _sparkleController.value * 2 * math.pi,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x22FFD700),
                      offset: const Offset(8, 8),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildAnimatedCards() {
    return SizedBox(
      width: 140,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carte arrière (plus sombre pour l'ombre)
          AnimatedBuilder(
            animation: _cardAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -15,
                  3 * math.sin(_cardAnimation.value * 2 * math.pi) - 8,
                ),
                child: Transform.rotate(
                  angle: -0.15 + 0.03 * math.sin(_cardAnimation.value * 2 * math.pi),
                  child: _buildRealisticCard(isBack: true),
                ),
              );
            },
          ),
          
          // Carte du milieu
          AnimatedBuilder(
            animation: _cardAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -5,
                  5 * math.sin(_cardAnimation.value * 2 * math.pi + 1) - 4,
                ),
                child: Transform.rotate(
                  angle: -0.05 + 0.03 * math.sin(_cardAnimation.value * 2 * math.pi + 1),
                  child: _buildRealisticCard(symbol: '♦', symbolColor: const Color(0xFFE31E24)),
                ),
              );
            },
          ),
          
          // Carte de devant (avec cœur)
          AnimatedBuilder(
            animation: _cardAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  5,
                  6 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                ),
                child: Transform.rotate(
                  angle: 0.08 + 0.03 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                  child: _buildRealisticCard(symbol: '♥', symbolColor: const Color(0xFFE31E24)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRealisticCard({String? symbol, Color? symbolColor, bool isBack = false}) {
    return Container(
      width: 85,
      height: 130,
      decoration: BoxDecoration(
        color: isBack ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Ombre principale
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: 0,
          ),
          // Ombre secondaire pour plus de profondeur
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
          // Ombre douce pour l'effet 3D
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: isBack ? Colors.grey.shade200 : Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: isBack 
        ? Container() // Carte arrière vide
        : Center(
            child: symbol != null 
              ? Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: symbolColor ?? Colors.black,
                  ),
                ) 
              : Container(),
          ),
    );
  }

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFFFD700)],
      ).createShader(bounds),
      child: const Text(
        'CHKOBA',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
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

  Widget _buildSubtitle() {
    return const Text(
      'Jeu de Cartes Tunisien Traditionnel',
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFFFFD700),
        fontWeight: FontWeight.w500,
        shadows: [
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

  Widget _buildProgressBar() {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingText() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        _loadingText,
        key: ValueKey(_loadingText),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

