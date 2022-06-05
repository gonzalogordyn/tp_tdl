import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'User.dart';
import 'views/SummonerLogin.dart';

void main() {
  runApp(MaterialApp(
    //initialRoute: '/home',
    home: SummonerInputScreen(),
    // routes: {
    //   '/': (context) => Loading(),
    //   '/summonerinput': (context) => SummonerInputScreen(),
    //   '/matchhistory': (context) => MatchHistory(),
    // },
  ));
}

