import 'package:test_project/request_resolvers/summoner_request_resolver.dart';
import '../request_resolvers/summoner_request_resolver.dart';
import '../model/live_match/live_match_participant.dart';
import '../model/live_match/live_match.dart';

LiveMatch buildLiveMatchFromJson(Map<String, dynamic> liveMatchJson, String region) {

  final isTutorialGame = liveMatchJson["gameMode"].toString().contains("TUTORIAL");
  if(isTutorialGame) {
    throw FormatException("Invalid game mode TUTORIAL");
  }
  List<LiveMatchParticipant> participants = liveMatchJson["participants"]
      .map<LiveMatchParticipant>((participantJson) => buildLiveMatchParticipantFromJson(participantJson))
      .toList();

  LiveMatch liveMatch = LiveMatch(participants: participants,
      gameMode: liveMatchJson["gameMode"],
      gameQueueConfigId: liveMatchJson["gameQueueConfigId"],
      mapId: liveMatchJson["mapId"],
  );


  if(liveMatchJson.containsKey("bannedChampions")) {
      List<int> bannedChampionsIds = liveMatchJson["bannedChampions"]
          .map<int>((
          bannedChampionsJson) => (bannedChampionsJson["championId"] as int))
          .toList();
      liveMatch.addBannedChampionsIds(bannedChampionsIds);
  }

  return liveMatch;
}

LiveMatchParticipant buildLiveMatchParticipantFromJson(Map<String, dynamic> participantJson) {

  return LiveMatchParticipant(summonerName: participantJson["summonerName"],
    summonerId: participantJson["summonerId"],
    spell1Id: participantJson["spell1Id"],
    spell2Id: participantJson["spell2Id"],
    championId: participantJson["championId"],
    profileIconId: participantJson["profileIconId"],
    perkStyle: participantJson["perks"]["perkStyle"],
    perkSubStyle: participantJson["perks"]["perkSubStyle"],
  );
}

String getChampionNameFromId(championJson, championId){
    var champ =  championJson["data"].values.firstWhere((champData) {
      return int.parse(champData["key"]) == championId;
    });
    String name = champ['id'].replaceAll(" ","");
    return (name.trim());
}

String getSummonerSpellNameFromId(summonerSpellJson, spellId){
  var spell =  summonerSpellJson["data"].values.firstWhere((spellData) {
    return int.parse(spellData["key"]) == spellId;
  });
  String name = spell['id'].replaceAll(" ","");
  return (name.trim());
}