class MatchParticipant {
  final String summonerName;
  final String championName;
  final String summonerPuuid;
  final int kills;
  final int deaths;
  final int assists;
  final List<int> build;
  final bool win;
  final String teamPosition;
  final int totalDamageDealtToChampions;
  final int totalDamageTaken;
  final int goldEarned;
  final int minionsKilled;
  final int jungleMinionsKilled;

  MatchParticipant({required this.summonerName,
    required this.championName,
    required this.summonerPuuid,
    required this.win,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.build,
    required this.teamPosition,
    required this.totalDamageDealtToChampions,
    required this.totalDamageTaken,
    required this.goldEarned,
    required this.jungleMinionsKilled,
    required this.minionsKilled
  });

  String getScoreAsString() {
    return "${kills.toString().padLeft(2, '0')}/${deaths.toString().padLeft(2, '0')}/${assists.toString().padLeft(2, '0')}";
  }

  String getKDA() {
    if (deaths == 0) {
      return "Perfect";
    }

    return ((kills + assists) / deaths).toStringAsFixed(2);
  }

}