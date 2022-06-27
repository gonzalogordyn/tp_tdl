class LiveMatchParticipant {
  final String summonerName;
  final int championId;
  final String summonerId;
  final int spell1Id;
  final int spell2Id;
  final int profileIconId;
  final int perkStyle;
  final int perkSubStyle;

  LiveMatchParticipant({required this.summonerName,
    required this.championId,
    required this.summonerId,
    required this.spell1Id,
    required this.spell2Id,
    required this.profileIconId,
    required this.perkStyle,
    required this.perkSubStyle
  });
}
