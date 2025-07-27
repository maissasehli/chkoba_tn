class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final AchievementType type;
  final int requiredValue;
  final int currentValue;
  final String reward;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.type,
    required this.requiredValue,
    this.currentValue = 0,
    this.reward = '',
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      iconName: json['icon_name'],
      isUnlocked: json['is_unlocked'] ?? false,
      unlockedAt: json['unlocked_at'] != null 
          ? DateTime.parse(json['unlocked_at']) 
          : null,
      type: AchievementType.values.firstWhere(
        (e) => e.toString() == 'AchievementType.${json['type']}',
        orElse: () => AchievementType.games,
      ),
      requiredValue: json['required_value'],
      currentValue: json['current_value'] ?? 0,
      reward: json['reward'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon_name': iconName,
      'is_unlocked': isUnlocked,
      'unlocked_at': unlockedAt?.toIso8601String(),
      'type': type.toString().split('.').last,
      'required_value': requiredValue,
      'current_value': currentValue,
      'reward': reward,
    };
  }

  double get progress {
    if (requiredValue == 0) return 0.0;
    return (currentValue / requiredValue).clamp(0.0, 1.0);
  }

  bool get canUnlock {
    return !isUnlocked && currentValue >= requiredValue;
  }

  AchievementModel copyWith({
    String? id,
    String? title,
    String? description,
    String? iconName,
    bool? isUnlocked,
    DateTime? unlockedAt,
    AchievementType? type,
    int? requiredValue,
    int? currentValue,
    String? reward,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      type: type ?? this.type,
      requiredValue: requiredValue ?? this.requiredValue,
      currentValue: currentValue ?? this.currentValue,
      reward: reward ?? this.reward,
    );
  }
}

enum AchievementType {
  games,      // Nombre de parties jouées
  victories,  // Nombre de victoires
  streak,     // Séries de victoires
  score,      // Scores élevés
  special,    // Réalisations spéciales
}

// lib/models/game_mode_model.dart
class GameModeModel {
  final String id;
  final String title;
  final String subtitle;
  final String iconName;
  final bool isAvailable;
  final bool isPrimary;
  final GameModeType type;
  final String? description;
  final int? maxPlayers;
  final Duration? estimatedDuration;

  GameModeModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
    this.isAvailable = true,
    this.isPrimary = false,
    required this.type,
    this.description,
    this.maxPlayers,
    this.estimatedDuration,
  });

  factory GameModeModel.fromJson(Map<String, dynamic> json) {
    return GameModeModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      iconName: json['icon_name'],
      isAvailable: json['is_available'] ?? true,
      isPrimary: json['is_primary'] ?? false,
      type: GameModeType.values.firstWhere(
        (e) => e.toString() == 'GameModeType.${json['type']}',
        orElse: () => GameModeType.quick,
      ),
      description: json['description'],
      maxPlayers: json['max_players'],
      estimatedDuration: json['estimated_duration'] != null
          ? Duration(minutes: json['estimated_duration'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'icon_name': iconName,
      'is_available': isAvailable,
      'is_primary': isPrimary,
      'type': type.toString().split('.').last,
      'description': description,
      'max_players': maxPlayers,
      'estimated_duration': estimatedDuration?.inMinutes,
    };
  }
}

enum GameModeType {
  quick,       // Partie rapide
  multiplayer, // Multijoueur
  tournament,  // Tournoi
  tutorial,    // Tutoriel
  challenge,   // Défi
}