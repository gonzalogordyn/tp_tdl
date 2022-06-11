import 'package:test_project/model/match/match_participant.dart';
import 'package:intl/intl.dart';

class Match{
  final List<MatchParticipant> participants;
  final String gameMode;
  final int gameEndTimestamp;

  Match({required this.participants, required this.gameMode, required this.gameEndTimestamp});

  getParticipantWithSummonerPuuid(String summonerPuuid) {
    return participants.firstWhere((participant) => participant.summonerPuuid == summonerPuuid);
  }

  String getDateAsString() {
    var datetime = DateTime.fromMillisecondsSinceEpoch(gameEndTimestamp);

    // 24 Hour format:
    return DateFormat('dd/MM/yyyy').format(datetime);
  }

}