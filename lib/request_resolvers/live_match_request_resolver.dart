import 'dart:convert';
import 'package:test_project/model_parsers/live_match_parser.dart';
import '../model/live_match/live_match.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

const Map<String, String> serverMapping = {"LAS": "la2",
  'NA': 'na1',
  'EUW': 'euw1',
  'EUNE': 'eun1',
  'LAN': 'la1',
  'BR': 'br1',
  'JP': 'jp1',
  'KR': 'kr',
  'TR': 'tr1',
  'OCE': 'oc1',
  'RU': 'ru'
};

Future<LiveMatch> fetchLiveMatch(String summonerID, String server) async {

  String apiKey = await rootBundle.loadString('assets/api_key.txt');
  String url = "https://${serverMapping[server]}.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/$summonerID";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": apiKey
  });

  // final String response = await rootBundle.loadString('assets/liveMatch.json');
  Map<String, dynamic> parsedJson = jsonDecode(res.body);
  // Map<String, dynamic> parsedJson = await jsonDecode(response);
  if (res.statusCode == 200) {
    return buildLiveMatchFromJson(parsedJson, server);
  } else {
    throw Exception('An error occurred fetching the live game. Please try again later. ${res.body}');
  }
  return buildLiveMatchFromJson(parsedJson, server);
}
