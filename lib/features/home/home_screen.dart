import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChkobaHomePage extends StatefulWidget {
  const ChkobaHomePage({Key? key}) : super(key: key);

  @override
  State<ChkobaHomePage> createState() => _ChkobaHomePageState();
}

class _ChkobaHomePageState extends State<ChkobaHomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _cardController;
  late AnimationController _sparkleController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _sparkleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _sparkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    );

    _sparkleAnimation = CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeInOut,
    );

    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    _cardController.repeat();
    _sparkleController.repeat();
    _pulseController.repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _cardController.dispose();
    _sparkleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _showFeatureSnackBar(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text('$feature en développement', style: const TextStyle(fontSize: 14)),
          ],
        ),
        backgroundColor: const Color(0xFF1877F2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
              ..._buildBackgroundDecorations(screenSize),
              
              // Contenu principal
              FadeTransition(
                opacity: _fadeAnimation,
                child: isLandscape 
                  ? _buildLandscapeLayout(screenSize)
                  : _buildPortraitLayout(screenSize),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(Size screenSize) {
    final safeHeight = screenSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    
    return Column(
      children: [
        // Header avec logo - 20% de la hauteur
        SizedBox(
          height: safeHeight * 0.2,
          child: _buildHeader(),
        ),
        
        // Section des modes de jeu - 60% de la hauteur
        SizedBox(
          height: safeHeight * 0.6,
          child: _buildGameModes(isPortrait: true),
        ),
        
        // Section du bas avec statistiques - 20% de la hauteur
        SizedBox(
          height: safeHeight * 0.2,
          child: _buildBottomSection(),
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
                Expanded(flex: 3, child: _buildHeader()),
                Expanded(flex: 2, child: _buildBottomSection()),
              ],
            ),
          ),
          
          const SizedBox(width: 16), // Espacement entre les colonnes
          
          // Colonne droite avec modes de jeu - 72% de la largeur
          Expanded(
            flex: 72,
            child: _buildGameModes(isPortrait: false),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo avec cartes animées
          SizedBox(
            width: 80,
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        -15 + 3 * math.sin(_cardAnimation.value * 2 * math.pi),
                        2 * math.sin(_cardAnimation.value * 2 * math.pi + 1),
                      ),
                      child: Transform.rotate(
                        angle: 0.1 * math.sin(_cardAnimation.value * 2 * math.pi),
                        child: _buildMiniCard('♥', const Color(0xFFE31E24), 28, 40),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _cardAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        15 + 3 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                        2 * math.sin(_cardAnimation.value * 2 * math.pi + 3),
                      ),
                      child: Transform.rotate(
                        angle: -0.1 * math.sin(_cardAnimation.value * 2 * math.pi),
                        child: _buildMiniCard('♦', const Color(0xFFFFD700), 28, 40),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Titre
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFFFFD700)],
            ).createShader(bounds),
            child: const Text(
              'CHKOBA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModes({required bool isPortrait}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isPortrait ? 24 : 16,
        vertical: isPortrait ? 16 : 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Titre de section
          Text(
            'Choisir un Mode',
            style: TextStyle(
              fontSize: isPortrait ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          // Grille des modes de jeu
          Expanded(
            child: isPortrait 
              ? _buildPortraitGameGrid()
              : _buildLandscapeGameGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitGameGrid() {
    return Column(
      children: [
        // Première ligne - Partie Rapide
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: _buildGameModeCard(
              title: 'Partie Rapide',
              subtitle: 'Jeu contre l\'IA',
              icon: Icons.flash_on,
              onTap: () => _showFeatureSnackBar('Partie rapide'),
              isPrimary: true,
            ),
          ),
        ),
        
        // Deuxième ligne - Deux boutons côte à côte
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: _buildGameModeCard(
                    title: 'Multijoueur',
                    subtitle: 'En ligne',
                    icon: Icons.people,
                    onTap: () => _showFeatureSnackBar('Multijoueur'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: _buildGameModeCard(
                    title: 'Tournoi',
                    subtitle: 'Compétition',
                    icon: Icons.emoji_events,
                    onTap: () => _showFeatureSnackBar('Tournoi'),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Troisième ligne - Deux boutons côte à côte
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: _buildGameModeCard(
                    title: 'Tutoriel',
                    subtitle: 'Apprendre',
                    icon: Icons.school,
                    onTap: () => _showFeatureSnackBar('Tutoriel'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: _buildGameModeCard(
                    title: 'Paramètres',
                    subtitle: 'Options',
                    icon: Icons.settings,
                    onTap: () => _showFeatureSnackBar('Paramètres'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeGameGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.0,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildGameModeCard(
            title: 'Partie Rapide',
            subtitle: 'Jeu contre l\'IA',
            icon: Icons.flash_on,
            onTap: () => _showFeatureSnackBar('Partie rapide'),
            isPrimary: true,
          ),
          _buildGameModeCard(
            title: 'Multijoueur',
            subtitle: 'En ligne',
            icon: Icons.people,
            onTap: () => _showFeatureSnackBar('Multijoueur'),
          ),
          _buildGameModeCard(
            title: 'Tournoi',
            subtitle: 'Compétition',
            icon: Icons.emoji_events,
            onTap: () => _showFeatureSnackBar('Tournoi'),
          ),
          _buildGameModeCard(
            title: 'Tutoriel',
            subtitle: 'Apprendre',
            icon: Icons.school,
            onTap: () => _showFeatureSnackBar('Tutoriel'),
          ),
        ],
      ),
    );
  }

  Widget _buildGameModeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return AnimatedBuilder(
      animation: isPrimary ? _pulseAnimation : _fadeAnimation,
      builder: (context, child) {
        final scale = isPrimary ? 1 + 0.05 * math.sin(_pulseAnimation.value * 2 * math.pi) : 1.0;
        
        return Transform.scale(
          scale: scale,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: isPrimary 
                    ? const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isPrimary 
                      ? Colors.white.withOpacity(0.3)
                      : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: isPrimary ? 32 : 28,
                      color: isPrimary ? const Color(0xFF8B0000) : Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isPrimary ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: isPrimary ? const Color(0xFF8B0000) : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isPrimary ? 12 : 10,
                        color: isPrimary 
                          ? const Color(0xFF8B0000).withOpacity(0.8)
                          : Colors.white.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Statistiques rapides
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Parties', '0', Icons.games),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildStatItem('Victoires', '0', Icons.star),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildStatItem('Score', '0', Icons.emoji_events),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFFFD700), size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniCard(String symbol, Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: width * 0.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundDecorations(Size screenSize) {
    return [
      // Étoile top-left
      Positioned(
        top: screenSize.height * 0.1,
        left: screenSize.width * 0.08,
        child: AnimatedBuilder(
          animation: _sparkleController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _sparkleController.value * 2 * math.pi,
              child: Icon(
                Icons.star,
                color: const Color(0x33FFD700),
                size: 25,
              ),
            );
          },
        ),
      ),
      
      // Carte flottante top-right
      Positioned(
        top: screenSize.height * 0.12,
        right: screenSize.width * 0.08,
        child: AnimatedBuilder(
          animation: _cardController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                3 * math.sin(_cardController.value * 2 * math.pi),
                4 * math.sin(_cardController.value * 2 * math.pi + 1),
              ),
              child: Container(
                width: 20,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0x33FFD700),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '♠',
                    style: TextStyle(
                      color: Color(0x77FFD700),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      
      // Cercle bottom-left
      Positioned(
        bottom: screenSize.height * 0.1,
        left: screenSize.width * 0.06,
        child: AnimatedBuilder(
          animation: _sparkleController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.1 * math.sin(_sparkleController.value * 2 * math.pi),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0x22FFD700),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    ];
  }
}