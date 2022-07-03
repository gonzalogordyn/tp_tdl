import 'package:flutter/material.dart';
import 'package:test_project/model/live_match/live_match_participant.dart';
import 'package:intl/intl.dart';

class LiveMatch{
  final List<LiveMatchParticipant> participants;
  final String gameMode;
  final int gameQueueConfigId;
  List<int> bannedChampionsIds = [];
  final int mapId;

  LiveMatch({required this.participants, required this.gameMode, required this.gameQueueConfigId, required this.mapId});


  String getQueueType(){
      switch(gameQueueConfigId){
        case 400: return "5v5 DRAFT PICK NORMAL";

        case 430: return "5v5 BLIND PICK NORMAL";

        case 420: return "5v5 RANKED SOLO";

        case 440: return "5v5 RANKED FLEX";

        case 450: return "5v5 ARAM";

        default: return "UNKNOWN GAME MODE";

      }
  }
  String getMapName(){
    switch(mapId){
      case 1: return "Summoner's Rift";

      case 2: return "Summoner's Rift";

      case 11: return "Summoner's Rift";

      case 12: return "Howling Abyss";

      default: return "Unknown Map";

    }
  }

  void addBannedChampionsIds(bannedChampions){
      bannedChampionsIds = bannedChampions;
  }

}
