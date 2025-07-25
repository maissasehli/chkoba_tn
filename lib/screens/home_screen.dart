import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChkobaHomePage extends StatefulWidget {
  const ChkobaHomePage({Key? key}) : super(key: key);

  @override
  State<ChkobaHomePage> createState() => _ChkobaHomePageState();
}

class _ChkobaHomePageState extends State<ChkobaHomePage>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _cardController;
  late AnimationController _pulseController;
  late AnimationController _slideController;

  late Animation<double> _backgroundAnimation;
  late Animation<double> _cardAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  int _selectedGameMode = 0;
  String _playerName = "Joueur"; // À récupérer depuis les préférences ou l'authentification

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _cardController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    );

    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    );

    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutQuart,
    ));
  }

  void _startAnimations() {
    _backgroundController.repeat();
    _cardController.repeat();
    _pulseController.repeat(reverse: true);
    _slideController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _cardController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
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
        child: SafeArea(
          child: Stack(
            children: [
              // Éléments décoratifs de fond
              ..._buildBackgroundDecorations(),
              
              // Contenu principal
              SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    // En-tête avec profil
                    _buildHeader(),
                    
                    // Contenu principal
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            
                            // Logo animé
                            _buildAnimatedLogo(),
                            
                            const SizedBox(height: 40),
                            
                            // Modes de jeu
                            _buildGameModes(),
                            
                            const SizedBox(height: 30),
                            
                            // Statistiques rapides
                            _buildQuickStats(),
                            
                            const SizedBox(height: 30),
                            
                            // Boutons d'action
                            _buildActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundDecorations() {
    return [
      // Motifs décoratifs tunisiens
      Positioned(
        top: 100,
        left: 30,
        child: AnimatedBuilder(
          animation: _backgroundAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _backgroundAnimation.value * 2 * math.pi,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0x11FFD700),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: const Color(0x33FFD700),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '☪',
                    style: TextStyle(
                      color: Color(0x55FFD700),
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      Positioned(
        top: 200,
        right: 40,
        child: AnimatedBuilder(
          animation: _cardAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.1 * math.sin(_cardAnimation.value * 2 * math.pi),
              child: Container(
                width: 40,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0x44FFD700),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '♠',
                    style: TextStyle(
                      color: Color(0x88FFD700),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      Positioned(
        bottom: 180,
        left: 60,
        child: AnimatedBuilder(
          animation: _backgroundAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: -_backgroundAnimation.value * 2 * math.pi,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0x44FFD700),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    '★',
                    style: TextStyle(
                      color: Color(0x55FFD700),
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Salutation
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marhaba $_playerName!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Prêt pour une partie?',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          
          // Avatar et notifications
          Row(
            children: [
              // Notification
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '👤',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Cartes flottantes
            Transform.translate(
              offset: Offset(
                -20 + 3 * math.sin(_cardAnimation.value * 2 * math.pi),
                3 * math.sin(_cardAnimation.value * 2 * math.pi + 1),
              ),
              child: Transform.rotate(
                angle: -0.2 + 0.05 * math.sin(_cardAnimation.value * 2 * math.pi),
                child: _buildFloatingCard('♥', const Color(0xFFE31E24)),
              ),
            ),
            
            Transform.translate(
              offset: Offset(
                20 + 3 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                3 * math.sin(_cardAnimation.value * 2 * math.pi + 3),
              ),
              child: Transform.rotate(
                angle: 0.2 + 0.05 * math.sin(_cardAnimation.value * 2 * math.pi + 2),
                child: _buildFloatingCard('♦', const Color(0xFFFFD700)),
              ),
            ),
            
            // Titre central
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0x44FFD700),
                  width: 1,
                ),
              ),
              child: const Text(
                'CHKOBA',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFloatingCard(String symbol, Color color) {
    return Container(
      width: 35,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildGameModes() {
    final gameModes = [
      {
        'title': 'Partie Rapide',
        'subtitle': 'Jouer contre l\'IA',
        'icon': Icons.flash_on,
        'color': const Color(0xFFFFD700),
      },
      {
        'title': 'Multijoueur',
        'subtitle': 'Défier des amis',
        'icon': Icons.people,
        'color': const Color(0xFF4CAF50),
      },
      {
        'title': 'Tournoi',
        'subtitle': 'Compétition en ligne',
        'icon': Icons.emoji_events,
        'color': const Color(0xFFFF9800),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 15),
          child: Text(
            'Modes de Jeu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        ...gameModes.asMap().entries.map((entry) {
          final index = entry.key;
          final mode = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedGameMode = index;
                  });
                  _handleGameModeSelection(index);
                },
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _selectedGameMode == index 
                        ? Colors.white.withOpacity(0.25)
                        : Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedGameMode == index 
                          ? mode['color'] as Color
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: mode['color'] as Color,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          mode['icon'] as IconData,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mode['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mode['subtitle'] as String,
                              style: const TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0x44FFD700),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tes Statistiques',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 15),
          
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Victoires', '12', Icons.emoji_events),
              ),
              Expanded(
                child: _buildStatItem('Parties', '25', Icons.games),
              ),
              Expanded(
                child: _buildStatItem('Rang', '#42', Icons.leaderboard),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD700).withOpacity(0.2),
            borderRadius: BorderRadius.circular(22.5),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFFD700),
            size: 24,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 2),
        
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Bouton principal - Commencer à jouer
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + 0.05 * _pulseAnimation.value,
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: const Color(0xFFE31E24),
                    elevation: 8,
                    shadowColor: const Color(0xFFFFD700).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Commencer à Jouer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(height: 15),
        
        // Boutons secondaires
        Row(
          children: [
            Expanded(
              child: _buildSecondaryButton(
                'Règles',
                Icons.help_outline,
                _showRules,
              ),
            ),
            
            const SizedBox(width: 12),
            
            Expanded(
              child: _buildSecondaryButton(
                'Classement',
                Icons.leaderboard,
                _showLeaderboard,
              ),
            ),
            
            const SizedBox(width: 12),
            
            Expanded(
              child: _buildSecondaryButton(
                'Profil',
                Icons.person_outline,
                _showProfile,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Méthodes d'action
  void _handleGameModeSelection(int index) {
    final modes = ['Partie Rapide', 'Multijoueur', 'Tournoi'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${modes[index]} sélectionné'),
        backgroundColor: const Color(0xFFE31E24),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _startGame() {
    // Navigation vers l'écran de jeu
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lancement du jeu...'),
        backgroundColor: Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
      ),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChkobaGamePage()));
  }

  void _showRules() {
    // Afficher les règles du jeu
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Règles de Chkoba'),
        content: const Text('Les règles du jeu seront affichées ici...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showLeaderboard() {
    // Afficher le classement
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Classement en cours de développement'),
        backgroundColor: Color(0xFFFF9800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showProfile() {
    // Afficher le profil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil en cours de développement'),
        backgroundColor: Color(0xFF2196F3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}