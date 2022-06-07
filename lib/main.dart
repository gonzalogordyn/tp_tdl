import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/views/SummonerHistory.dart';
import 'SummonerMatchInfo.dart';
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

