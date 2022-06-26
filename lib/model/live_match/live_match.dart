import 'package:flutter/material.dart';
import 'package:test_project/model/live_match/live_match_participant.dart';
import 'package:intl/intl.dart';

class LiveMatch{
  final List<LiveMatchParticipant> participants;
  final String gameMode;
  final int gameQueueConfigId;
  final List<int> bannedChampionsIds;

  LiveMatch({required this.participants, required this.gameMode, required this.gameQueueConfigId, required this.bannedChampionsIds});

}
