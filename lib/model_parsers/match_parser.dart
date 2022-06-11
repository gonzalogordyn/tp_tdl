import '../model/match/match_participant.dart';
import '../model/match/match.dart';

Match buildMatchFromJson(Map<String, dynamic> json) {
  final isTutorialGame = json["info"]["gameMode"].toString().contains("TUTORIAL");
  if(isTutorialGame) {
    throw FormatException("Invalid game mode TUTORIAL");
  }
  List<MatchParticipant> participants = json["info"]["participants"]
      .map<MatchParticipant>((participantJson) => buildMatchParticipantFromJson(participantJson))
      .toList();
  return Match(participants: participants,
      gameMode: json["info"]["gameMode"],
      gameEndTimestamp: json["info"]["gameEndTimestamp"]);
}

MatchParticipant buildMatchParticipantFromJson(Map<String, dynamic> json) {
  List<int> build = [
    json["item0"],
    json["item1"],
    json["item2"],
    json["item3"],
    json["item4"],
    json["item5"]
  ];
  return MatchParticipant(summonerName: json["summonerName"],
      championName: json["championName"],
      summonerPuuid: json["puuid"],
      win: json["win"],
      kills: json["kills"],
      deaths: json["deaths"],
      assists: json["assists"],
      build: build);
}