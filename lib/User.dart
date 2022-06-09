import 'dart:convert';
import 'package:http/http.dart' as http;
import '../SummonerMatchInfo.dart';

const String API_KEY = "RGAPI-818c6a07-3e3a-4442-ad80-9057c72fe28b";

class User {
    late String summonerName;
    late String serverID;


    User(this.summonerName, this.serverID);

}

