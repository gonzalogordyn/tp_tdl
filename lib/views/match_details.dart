import 'package:flutter/material.dart';
import '../model/match/match.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({Key? key, required this.summonerMatchInfo}) : super(key: key);

  final Match summonerMatchInfo;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff263F65),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Imagen"),
                    Text("runas"),
                    Text("summoners"),
                    Text("nombre"),
                    Text("kda"),
                    Text("items"),
                  ],
                )
              ],
            )

          ],
        )
    );
  }

}