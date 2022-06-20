import 'dart:convert';

import 'package:test_project/model/summoner/league.dart';

class Summoner {
    final String? summonerName;
    final String? summonerId;
    final String? summonerPuuid;
    final int? summonerIconId;
    final int? summonerLevel;
    List<League> summonerLeagues = [];

    Summoner({this.summonerName, this.summonerId, this.summonerPuuid, this.summonerIconId, this.summonerLevel});

    factory Summoner.fromJson(Map<String, dynamic> data) {
        Summoner summoner;

        final summonerName = data["name"];
        final summonerId = data["id"];
        final summonerPuuid = data["puuid"];
        final summonerIconId = data["profileIconId"];
        final summonerLevel = data["summonerLevel"];

        summoner = Summoner(summonerName: summonerName, summonerId: summonerId, summonerPuuid: summonerPuuid,
        summonerIconId: summonerIconId, summonerLevel: summonerLevel);

        if(data["leagues"] != null) {
            List<League> leagues = [];
            List<dynamic> leagueInfo = data["leagues"];
            for(dynamic league in leagueInfo) {
                leagues.add(League.fromJson(league));
            }

            summoner.addLeagueInfo(leagues);
        }

        return summoner;
    }


    String? getSummonerPuuid(){
        return summonerPuuid;
    }

    String stringify() {
        Map<String, dynamic> summData = {
            "name": summonerName,
            "id": summonerId,
            "puuid": summonerPuuid,
            "profileIconId": summonerIconId,
            "summonerLevel": summonerLevel,
            "leagues": summonerLeagues,
        };

        return jsonEncode(summData);
    }

    void addLeagueInfo(List<League> leagues) {
        summonerLeagues.addAll(leagues);
    }

    //Returns the user's solo queue info. If it doesnt exist, returns the flex queue info.
    League? getSummonerMainLeague() {
        if(summonerLeagues.isEmpty) {
            return null;
        }

        int soloQueueIndex = summonerLeagues.indexWhere((league) => league.queueType == "Ranked solo");

        if(soloQueueIndex >= 0) {
            return summonerLeagues[soloQueueIndex];
        } else {
            return summonerLeagues[0];
        }
    }
}