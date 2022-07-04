import '../model/match/match.dart';
import '../model_parsers/match_parser.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO: Mover API_KEY a un archivo de configuracion
const String apiKey = "RGAPI-15692da6-2d90-4de1-a762-4f9ec0110243";

const Map<String, String> serverMapping = {"LAS": "americas",
  'NA': 'americas',
  'EUW': 'europe',
  'EUNE': 'europe',
  'LAN': 'americas',
  'BR': 'americas',
  'JP': 'asia',
  'KR': 'asia',
  'TR': 'europe',
  'OCE': 'sea',
  'RU': 'europe'
};

Future<List<Match>> fetchMatchHistory(String summonerPuuid, int start, int count, String server) async {
  var matchIds = await fetchMatchIds(summonerPuuid, start, count, server);
  List<Match> matchHistoryInfo = [];

  for (var matchId in matchIds) {
    try {
      Match matchInfo = await fetchSummonerMatchInfo(summonerPuuid, matchId, server);
      matchHistoryInfo.add(matchInfo);
    } on FormatException {
      // Received tutorial game. Nothing to do
    }
  }

  return matchHistoryInfo;
}

Future<List<dynamic>> fetchMatchIds(String summonerPuuid, int start, int count, String server) async {
  // String base = "${serverMapping[server]}.api.riotgames.com";
  String base = "${serverMapping[server]}.api.riotgames.com";
  String endpoint = "/lol/match/v5/matches/by-puuid/$summonerPuuid/ids";
  final params = {
    'start': start.toString(),
    'count': count.toString()
  };
  var matchIdsResult = await http.get(Uri.https(base, endpoint, params), headers: {
    "X-Riot-Token": apiKey
  });
  await Future.delayed(Duration(seconds: 1));

  return jsonDecode(matchIdsResult.body);
}

Future<Match> fetchSummonerMatchInfo(String summonerPuuid, String matchId, String server) async {
  String url = "https://${serverMapping[server]}.api.riotgames.com/lol/match/v5/matches/$matchId";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": apiKey
  });

  String timelineUrl = "https://${serverMapping[server]}.api.riotgames.com/lol/match/v5/matches/$matchId/timeline";
  var timelineRes = await http.get(Uri.parse(timelineUrl), headers: {
    "X-Riot-Token": apiKey
  });

  Map<String, dynamic> parsedJson = jsonDecode(res.body);
  Map<String, dynamic> timelineJson = jsonDecode(timelineRes.body);
  if (res.statusCode == 200) {
    return buildMatchFromJson(parsedJson, timelineJson, server);
  } else {
    throw Exception('An error occurred fetching the match data with id $matchId. Please try again later. ${res.body}');
  }
}