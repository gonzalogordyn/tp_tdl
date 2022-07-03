import 'dart:convert';
import '../model/summoner/league.dart';
import '../model/summoner/summoner.dart';
import 'package:http/http.dart' as http;

//TODO: Mover API_KEY a un archivo de configuracion
const String apiKey = "RGAPI-8a5f7d0b-18cd-4536-a123-3873a3d4747b";

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

Future<Summoner> fetchSummonerInfo(String summonerName, String server) async {

  // TODO: que cambie url segun el server elegido

  String url = "https://${serverMapping[server]}.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": apiKey
  });

  Map<String, dynamic> parsedJson = jsonDecode(res.body);
  if (res.statusCode == 200) {
    return Summoner.fromJson(parsedJson, server);
  } else {
    throw Exception('An error occurred fetching the summoner data with name $summonerName. Please try again later. ${res.body}');
  }
}

Future<List<League>> fetchSummonerLeagueInfo(String summonerId, String server) async {
  // TODO: que cambie url segun el server elegido

  String url = "https://${serverMapping[server]}.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId";
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