import 'dart:convert';

class Summoner {
    final String? summonerName;
    final String? summonerId;
    final String? summonerPuuid;
    final int? summonerIconId;
    final int? summonerLevel;

    Summoner({this.summonerName, this.summonerId, this.summonerPuuid, this.summonerIconId, this.summonerLevel});

    factory Summoner.fromJson(Map<String, dynamic> data) {

        final summonerName = data["name"];
        final summonerId = data["id"];
        final summonerPuuid = data["puuid"];
        final summonerIconId = data["profileIconId"];
        final summonerLevel = data["summonerLevel"];

        return Summoner(summonerName: summonerName, summonerId: summonerId, summonerPuuid: summonerPuuid,
        summonerIconId: summonerIconId, summonerLevel: summonerLevel);
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
            "summonerLevel": summonerLevel
        };

        return jsonEncode(summData);
    }
}