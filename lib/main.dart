import 'package:flutter/material.dart';
import 'package:test_project/views/SummonerHistory.dart';
import 'SummonerMatchInfo.dart';
import 'User.dart';
import 'views/SummonerLogin.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: TextTheme(
        headline4: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: GoogleFonts.inter().fontFamily,
          color: Color(0xff263F65),
        ),
        headline5: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          fontFamily: GoogleFonts.inter().fontFamily,
          color: Color(0xff263F65),
        ),
      )
    ),
    initialRoute: '/summonerinput',
    routes: {
    //   '/': (context) => Loading(),
       '/summonerinput': (context) => SummonerInputScreen(),
       //'/matchhistory': (context) => SummonerHistory(),
    },
  ));
}

