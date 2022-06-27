import 'dart:convert';
import 'package:test_project/model_parsers/live_match_parser.dart';
import '../model/live_match/live_match.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

//TODO: Mover API_KEY a un archivo de configuracion
const String apiKey = "RGAPI-54ebb12d-a62d-4da2-bbfb-a78d8f8bdc9b";

Future<LiveMatch> fetchLiveMatch(String summonerID) async {

  // TODO: que cambie url segun el server elegido

  String url = "https://la2.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/$summonerID";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": apiKey
  });

  final String response = await rootBundle.loadString('assets/liveMatch.json');
  //Map<String, dynamic> parsedJson = jsonDecode(res.body);
  Map<String, dynamic> parsedJson = await jsonDecode(response);
  // if (res.statusCode == 200) {
  //   return buildLiveMatchFromJson(parsedJson);
  // } else {
  //   throw Exception('An error occurred fetching the live game. Please try again later. ${res.body}');
  // }
  return buildLiveMatchFromJson(parsedJson);
}
