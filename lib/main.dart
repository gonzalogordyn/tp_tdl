import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/views/SummonerHistory.dart';
import 'SummonerMatchInfo.dart';
import 'Summoner.dart';
import 'views/SummonerLogin.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/summonerinput',
    routes: {
    //   '/': (context) => Loading(),
       '/summonerinput': (context) => SummonerInputScreen(),
       //'/matchhistory': (context) => SummonerHistory(),
    },
  ));
}

