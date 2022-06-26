import 'dart:convert';
import 'package:test_project/model_parsers/live_match_parser.dart';
import '../model/live_match/live_match.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

//TODO: Mover API_KEY a un archivo de configuracion
const String apiKey = "RGAPI-4cffd502-45e3-41ef-914b-c32c1b39c5df";

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

// Future<String> getChampionName(championId) async{
//   String url = "http://ddragon.leagueoflegends.com/cdn/12.11.1/data/en_US/champion.json";
//   var res = await http.get(Uri.parse(url), headers: {
//     "X-Riot-Token": apiKey
//   });
//   var parsedJson = jsonDecode(res.body);
//
//   Map<String, dynamic> parsedJson = await jsonDecode(response);
//
//   if (res.statusCode == 200){
//       return getChampionNameFromId(parsedJson, championId);
//   } else {
//     throw Exception('Something went wrong. ${res.body}');
//   }
//   return getChampionNameFromId(parsedJson, championId);
// }