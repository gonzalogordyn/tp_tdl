import '../model/match/match_participant.dart';
import '../model/match/match.dart';

Match buildMatchFromJson(Map<String, dynamic> matchJson, Map<String, dynamic> matchTimelineJson) {
  final isTutorialGame = matchJson["info"]["gameMode"].toString().contains("TUTORIAL");
  if(isTutorialGame) {
    throw FormatException("Invalid game mode TUTORIAL");
  }
  List<MatchParticipant> participants = matchJson["info"]["participants"]
      .map<MatchParticipant>((participantJson) => buildMatchParticipantFromJson(participantJson, matchTimelineJson))
      .toList();
  return Match(participants: participants,
      gameMode: matchJson["info"]["gameMode"],
      gameEndTimestamp: matchJson["info"]["gameEndTimestamp"]);
}

MatchParticipant buildMatchParticipantFromJson(Map<String, dynamic> participantJson, Map<String, dynamic> matchTimelineJson) {
  List<int> build = [
    participantJson["item0"],
    participantJson["item1"],
    participantJson["item2"],
    participantJson["item3"],
    participantJson["item4"],
    participantJson["item5"]
  ];
  List<dynamic> frames = matchTimelineJson["info"]["frames"];
  Map<String, dynamic> gameEndFrame = frames.firstWhere((frame) => (frame["events"] as List<dynamic>).any((event) => event["type"] == "GAME_END"));
  int participantMatchTimeLineId = (matchTimelineJson["info"]["participants"] as List<dynamic>).firstWhere((participant) => participant["puuid"] == participantJson["puuid"])["participantId"];
  return MatchParticipant(summonerName: participantJson["summonerName"],
      championName: participantJson["championName"],
      summonerPuuid: participantJson["puuid"],
      win: participantJson["win"],
      kills: participantJson["kills"],
      deaths: participantJson["deaths"],
      assists: participantJson["assists"],
      teamPosition: participantJson["teamPosition"],
      build: build,
      totalDamageDealtToChampions: participantJson["totalDamageDealtToChampions"],
      minionsKilled: gameEndFrame["participantFrames"]["$participantMatchTimeLineId"]["minionsKilled"],
      jungleMinionsKilled: gameEndFrame["participantFrames"]["$participantMatchTimeLineId"]["jungleMinionsKilled"],
      totalDamageTaken: participantJson["totalDamageTaken"],
      goldEarned: participantJson["goldEarned"]);
}