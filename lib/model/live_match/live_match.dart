import 'package:flutter/material.dart';
import 'package:test_project/model/live_match/live_match_participant.dart';
import 'package:intl/intl.dart';

class LiveMatch{
  final List<LiveMatchParticipant> participants;
  final String gameMode;
  final int gameQueueConfigId;
  final List<int> bannedChampionsIds;
  final int mapId;

  LiveMatch({required this.participants, required this.gameMode, required this.gameQueueConfigId, required this.mapId,required this.bannedChampionsIds});


  String getQueueType(){
      switch(gameQueueConfigId){
        case 400: return "5v5 DRAFT PICK NORMAL";
        break;

        case 430: return "5v5 BLIND PICK NORMAL";
        break;

        case 420: return "5v5 RANKED SOLO";
        break;

        case 440: return "5v5 RANKED FLEX";
        break;

        case 450: return "5v5 ARAM";
        break;

        default: return "UNKNOWN GAME MODE";

      }
  }
  String getMapName(){
    switch(mapId){
      case 1: return "Summoner's Rift";
      break;

      case 2: return "Summoner's Rift";
      break;

      case 11: return "Summoner's Rift";
      break;

      case 12: return "Howling Abyss";
      break;

      default: return "Unknown Map";

    }
  }

}
