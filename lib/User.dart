import 'dart:convert';
import 'package:http/http.dart' as http;
import '../SummonerMatchInfo.dart';

const String API_KEY = "RGAPI-818c6a07-3e3a-4442-ad80-9057c72fe28b";

class User {
    late String summonerName;
    late String serverID;
    final String summonerPuuid = "Jm1edPNuEnyrMqbf0fEhzHIP6o5KHqUcBxJl8tC7ZGUdEfY1nli8ViVsBp_7mSkp7alrSQ47Y-lwqQ";
    late Future<List<SummonerMatchInfo>> matchHistoryInfo;

    User(this.summonerName, this.serverID){
        matchHistoryInfo = fetchMatchHistory(summonerPuuid, 0, 10);
    }

}

Future<List<SummonerMatchInfo>> fetchMatchHistory(String summonerPuuid, int start, int count) async {
    var matchIds = await fetchMatchIds(summonerPuuid, start, count);
    List<SummonerMatchInfo> matchHistoryInfo = [];

    for (var matchId in matchIds) {
        SummonerMatchInfo matchInfo = await fetchSummonerMatchInfo(summonerPuuid, matchId);
        matchHistoryInfo.add(matchInfo);
    }

    return matchHistoryInfo;
}

Future<List<dynamic>> fetchMatchIds(String summonerPuuid, int start, int count) async {
    String base = "americas.api.riotgames.com";
    String endpoint = "/lol/match/v5/matches/by-puuid/${summonerPuuid}/ids";
    final params = {
        'start': start.toString(),
        'count': count.toString()
    };
    var matchIdsResult = await http.get(Uri.https(base, endpoint, params), headers: {
        "X-Riot-Token": API_KEY
    });
    await Future.delayed(Duration(seconds: 1));

    return jsonDecode(matchIdsResult.body);
}

Future<SummonerMatchInfo> fetchSummonerMatchInfo(String summonerPuuid, String matchId) async {
    String url = "https://americas.api.riotgames.com/lol/match/v5/matches/${matchId}";
    var res = await http.get(Uri.parse(url), headers: {
        "X-Riot-Token": "RGAPI-818c6a07-3e3a-4442-ad80-9057c72fe28b"
    });

    Map<String, dynamic> parsedJson = jsonDecode(res.body);
    if (res.statusCode == 200) {
        return SummonerMatchInfo.fromJson(summonerPuuid, parsedJson);
    } else {
        throw Exception('An error ocurred fetching the match data with id $matchId. Please try again later. ${res.body}');
    }
}