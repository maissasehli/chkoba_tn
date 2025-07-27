class GameStatsModel {
  final int gamesPlayed;
  final int victories;
  final int defeats;
  final double winRate;
  final int bestScore;
  final int currentStreak;
  final int longestStreak;
  final int totalPoints;

  GameStatsModel({
    this.gamesPlayed = 0,
    this.victories = 0,
    this.defeats = 0,
    this.winRate = 0.0,
    this.bestScore = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalPoints = 0,
  });

  factory GameStatsModel.fromJson(Map<String, dynamic> json) {
    return GameStatsModel(
      gamesPlayed: json['games_played'] ?? 0,
      victories: json['victories'] ?? 0,
      defeats: json['defeats'] ?? 0,
      winRate: (json['win_rate'] ?? 0.0).toDouble(),
      bestScore: json['best_score'] ?? 0,
      currentStreak: json['current_streak'] ?? 0,
      longestStreak: json['longest_streak'] ?? 0,
      totalPoints: json['total_points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'games_played': gamesPlayed,
      'victories': victories,
      'defeats': defeats,
      'win_rate': winRate,
      'best_score': bestScore,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'total_points': totalPoints,
    };
  }

  GameStatsModel copyWith({
    int? gamesPlayed,
    int? victories,
    int? defeats,
    double? winRate,
    int? bestScore,
    int? currentStreak,
    int? longestStreak,
    int? totalPoints,
  }) {
    return GameStatsModel(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      victories: victories ?? this.victories,
      defeats: defeats ?? this.defeats,
      winRate: winRate ?? this.winRate,
      bestScore: bestScore ?? this.bestScore,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }

  // Calculer le taux de victoire
  double calculateWinRate() {
    if (gamesPlayed == 0) return 0.0;
    return (victories / gamesPlayed) * 100;
  }

  // Mettre à jour les statistiques après une partie
  GameStatsModel updateAfterGame({
    required bool isVictory,
    required int score,
  }) {
    final newGamesPlayed = gamesPlayed + 1;
    final newVictories = isVictory ? victories + 1 : victories;
    final newDefeats = !isVictory ? defeats + 1 : defeats;
    final newWinRate = (newVictories / newGamesPlayed) * 100;
    final newBestScore = score > bestScore ? score : bestScore;
    final newCurrentStreak = isVictory ? currentStreak + 1 : 0;
    final newLongestStreak = newCurrentStreak > longestStreak ? newCurrentStreak : longestStreak;
    final newTotalPoints = totalPoints + score;

    return GameStatsModel(
      gamesPlayed: newGamesPlayed,
      victories: newVictories,
      defeats: newDefeats,
      winRate: newWinRate,
      bestScore: newBestScore,
      currentStreak: newCurrentStreak,
      longestStreak: newLongestStreak,
      totalPoints: newTotalPoints,
    );
  }
}
