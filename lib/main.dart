import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/views/summoner_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: TextTheme(
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: GoogleFonts.inter().fontFamily,
          color: Color(0xff263F65),
        ),
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

