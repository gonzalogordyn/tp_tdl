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

  MatchParticipant({required this.summonerName,
    required this.championName,
    required this.summonerPuuid,
    required this.win,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.build,
    required this.teamPosition,
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