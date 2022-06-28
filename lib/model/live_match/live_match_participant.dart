import '../summoner/league.dart';
import '../../request_resolvers/summoner_request_resolver.dart';

class LiveMatchParticipant {
  final String summonerName;
  final int championId;
  final String summonerId;
  final int spell1Id;
  final int spell2Id;
  final int profileIconId;
  final int perkStyle;
  final int perkSubStyle;
  List<League> leagues = [];

  LiveMatchParticipant({required this.summonerName,
    required this.championId,
    required this.summonerId,
    required this.spell1Id,
    required this.spell2Id,
    required this.profileIconId,
    required this.perkStyle,
    required this.perkSubStyle,
  });

  void addLeagueInfo() async{
    leagues.addAll(await fetchSummonerLeagueInfo(summonerId));
  }

  //Returns the user's solo queue info. If it doesnt exist, returns the flex queue info.
  League? getSummonerLeague() {
    if(leagues.isEmpty) {
      return League.unranked();
    }

    int soloQueueIndex = leagues.indexWhere((league) => league.queueType == "Ranked solo");

    if(soloQueueIndex >= 0) {
      print(leagues[0].tier);
      return leagues[soloQueueIndex];
    } else {
      print(leagues[0].tier);
      return leagues[0];
    }
  }
}
