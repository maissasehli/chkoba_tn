import 'package:chkoba_tn/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

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
    
    // Forcer l'orientation horizontale
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
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
            
            // Contenu principal - Utilisation d'un SingleChildScrollView pour éviter l'overflow
            SafeArea(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(_fadeAnimation),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Adapter la mise en page selon l'espace disponible
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
                                  // Espacement flexible
                                  const Spacer(flex: 1),
                                  
                                  // Logo avec cartes animées (taille réduite en mode compact)
                                  _buildAnimatedCards(isCompact: isCompact),
                                  
                                  SizedBox(height: isCompact ? 20 : 30),
                                  
                                  // Titre principal (taille réduite en mode compact)
                                  _buildTitle(isCompact: isCompact),
                                  
                                  SizedBox(height: isCompact ? 8 : 12),
                                  
                                  // Sous-titre
                                  _buildSubtitle(isCompact: isCompact),
                                  
                                  SizedBox(height: isCompact ? 30 : 40),
                                  
                                  // Barre de progression
                                  _buildProgressBar(),
                                  
                                  SizedBox(height: isCompact ? 12 : 16),
                                  
                                  // Texte de chargement
                                  _buildLoadingText(isCompact: isCompact),
                                  
                                  // Espacement flexible
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

  List<Widget> _buildBackgroundDecorations() {
    return [
      // Étoiles scintillantes (positions adaptées au mode paysage)
      Positioned(
        top: 60,
        left: 50,
        child: AnimatedBuilder(
          animation: _sparkleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.3 * math.sin(_sparkleAnimation.value * 2 * math.pi),
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
        top: 100,
        right: 70,
        child: AnimatedBuilder(
          animation: _sparkleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.3 * math.sin(_sparkleAnimation.value * 2 * math.pi + 1),
              child: const Icon(
                Icons.star,
                color: Color(0x33FFD700),
                size: 20,
              ),
            );
          },
        ),
      ),
      
      Positioned(
        bottom: 80,
        left: 80,
        child: AnimatedBuilder(
          animation: _sparkleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.3 * math.sin(_sparkleAnimation.value * 2 * math.pi + 2),
              child: const Icon(
                Icons.star,
                color: Color(0x33FFD700),
                size: 18,
              ),
            );
          },
        ),
      ),
      
      // Croissant décoratif
      Positioned(
        top: 80,
        right: 100,
        child: AnimatedBuilder(
          animation: _sparkleController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _sparkleController.value * 2 * math.pi,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x22FFD700),
                      offset: const Offset(6, 6),
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

  Widget _buildAnimatedCards({bool isCompact = false}) {
    double cardWidth = isCompact ? 70 : 85;
    double cardHeight = isCompact ? 105 : 130;
    double containerWidth = isCompact ? 120 : 140;
    double containerHeight = isCompact ? 140 : 180;
    
    return SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carte arrière (plus sombre pour l'ombre)
          AnimatedBuilder(
            animation: _cardAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -12,
                  3 * math.sin(_cardAnimation.value * 2 * math.pi) - 6,
                ),
                child: Transform.rotate(
                  angle: -0.15 + 0.03 * math.sin(_cardAnimation.value * 2 * math.pi),
                  child: _buildRealisticCard(
                    isBack: true, 
                    width: cardWidth, 
                    height: cardHeight
                  ),
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
                  -4,
                  4 * math.sin(_cardAnimation.value * 2 * math.pi + 1) - 3,
                ),
                child: Transform.rotate(
                  angle: -0.05 + 0.03 * math.sin(_cardAnimation.value * 2 * math.pi + 1),
                  child: _buildRealisticCard(
                    symbol: '♦', 
                    symbolColor: const Color(0xFFE31E24),
                    width: cardWidth, 
                    height: cardHeight,
                    fontSize: isCompact ? 24 : 28,
                  ),
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
                  4,
                  5 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                ),
                child: Transform.rotate(
                  angle: 0.08 + 0.03 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                  child: _buildRealisticCard(
                    symbol: '♥', 
                    symbolColor: const Color(0xFFE31E24),
                    width: cardWidth, 
                    height: cardHeight,
                    fontSize: isCompact ? 24 : 28,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRealisticCard({
    String? symbol, 
    Color? symbolColor, 
    bool isBack = false,
    double width = 85,
    double height = 130,
    double fontSize = 28,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isBack ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Ombre principale
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          // Ombre secondaire pour plus de profondeur
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 6,
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
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: symbolColor ?? Colors.black,
                  ),
                ) 
              : Container(),
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

  Widget _buildProgressBar() {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            height: 5,
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

  Widget _buildLoadingText({bool isCompact = false}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        _loadingText,
        key: ValueKey(_loadingText),
        style: TextStyle(
          color: Colors.white,
          fontSize: isCompact ? 13 : 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}