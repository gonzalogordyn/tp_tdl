import 'dart:convert';
import '../model/summoner/league.dart';
import '../model/summoner/summoner.dart';
import 'package:http/http.dart' as http;

//TODO: Mover API_KEY a un archivo de configuracion
const String apiKey = "RGAPI-c9a0d21d-aca4-4021-a555-2dd4e46948df";

Future<Summoner> fetchSummonerInfo(String summonerName) async {

  // TODO: que cambie url segun el server elegido

  String url = "https://la2.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": apiKey
  });

  Map<String, dynamic> parsedJson = jsonDecode(res.body);
  if (res.statusCode == 200) {
    return Summoner.fromJson(parsedJson);
  } else {
    throw Exception('An error occurred fetching the summoner data with name $summonerName. Please try again later. ${res.body}');
  }
}

Future<List<League>> fetchSummonerLeagueInfo(String summonerId) async {
  // TODO: que cambie url segun el server elegido

  String url = "https://la2.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": apiKey
  });

  List<dynamic> parsedJson = jsonDecode(res.body);
  if (res.statusCode == 200) {
    List<League> leagues = [];

    for(dynamic leagueInfo in parsedJson) {
      leagues.add(League.fromJson(leagueInfo));
    }

    return leagues;
  } else {
    throw Exception('An error occurred fetching the summoner league info with id $summonerId. Please try again later. ${res.body}');
  }
}