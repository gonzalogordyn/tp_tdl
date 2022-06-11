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
    return "$kills/$deaths/$assists";
  }

  String getKDA() {
    if (deaths == 0) {
      return "0";
    }

    return ((kills + assists) / deaths).toStringAsFixed(2);
  }

}