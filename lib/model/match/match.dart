import 'package:flutter/material.dart';
import 'package:test_project/model/match/match_participant.dart';
import 'package:intl/intl.dart';

class Match{
  final List<MatchParticipant> participants;
  final String gameMode;
  final int gameEndTimestamp;
  final String region;

  Match({required this.participants, required this.gameMode, required this.gameEndTimestamp, required this.region});

  getParticipantWithSummonerPuuid(String summonerPuuid) {
    try {
      return participants.firstWhere((participant) => participant.summonerPuuid == summonerPuuid);
    } on StateError catch (_) {
      return null;
    }
  }

  isClassicMode() {
    return gameMode == "CLASSIC";
  }

  getParticipantWithSummonerName(String summonerName) {
    try {
      return participants.firstWhere((participant) => participant.summonerName == summonerName);
    } on StateError catch (_) {
      return null;
    }
  }

  String getDateAsString() {
    var datetime = DateTime.fromMillisecondsSinceEpoch(gameEndTimestamp);

    // 24 Hour format:
    return DateFormat('dd/MM/yyyy').format(datetime);
  }

}