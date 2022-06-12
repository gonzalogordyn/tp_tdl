import 'dart:convert';
import '../model/summoner.dart';
import 'package:http/http.dart' as http;

//TODO: Mover API_KEY a un archivo de configuracion
const String apiKey = "RGAPI-dd353d72-0c6d-43b0-9bf3-587f10d28b03";

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