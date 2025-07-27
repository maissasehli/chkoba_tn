import 'package:flutter/material.dart';
import 'dart:math' as math;

class GameModesWidget extends StatelessWidget {
  final bool isPortrait;
  final VoidCallback onQuickGame;
  final VoidCallback onMultiplayer;
  final VoidCallback onTournament;
  final VoidCallback onTutorial;
  final AnimationController pulseController;

  const GameModesWidget({
    Key? key,
    required this.isPortrait,
    required this.onQuickGame,
    required this.onMultiplayer,
    required this.onTournament,
    required this.onTutorial,
    required this.pulseController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onTap: onQuickGame,
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
                    onTap: onMultiplayer,
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
                    onTap: onTournament,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Troisième ligne - Tutoriel uniquement
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: _buildGameModeCard(
              title: 'Tutoriel',
              subtitle: 'Apprendre à jouer',
              icon: Icons.school,
              onTap: onTutorial,
            ),
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
            onTap: onQuickGame,
            isPrimary: true,
          ),
          _buildGameModeCard(
            title: 'Multijoueur',
            subtitle: 'En ligne',
            icon: Icons.people,
            onTap: onMultiplayer,
          ),
          _buildGameModeCard(
            title: 'Tournoi',
            subtitle: 'Compétition',
            icon: Icons.emoji_events,
            onTap: onTournament,
          ),
          _buildGameModeCard(
            title: 'Tutoriel',
            subtitle: 'Apprendre',
            icon: Icons.school,
            onTap: onTutorial,
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
      animation: isPrimary ? pulseController : const AlwaysStoppedAnimation(0),
      builder: (context, child) {
        final scale = isPrimary 
          ? 1 + 0.05 * math.sin(pulseController.value * 2 * math.pi) 
          : 1.0;
        
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
}