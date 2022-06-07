import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:test_project/SummonerMatchInfo.dart';
import 'package:test_project/components/Item.dart';

class MatchPreview extends StatelessWidget {
  final SummonerMatchInfo summonerMatchInfo;

  MatchPreview({
    Key? key,
    required this.summonerMatchInfo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: summonerMatchInfo.won ? Colors.blueAccent : Colors.redAccent,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Image.network(
                'http://ddragon.leagueoflegends.com/cdn/12.10.1/img/champion/${summonerMatchInfo.championName}.png',
                width: 70,
                height: 70
            )
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(summonerMatchInfo.getScoreAsString(), style: TextStyle(fontSize: 25)),
                Text("KDA: ${summonerMatchInfo.getKDA()}", style: TextStyle(fontSize: 18)),
              ]
            )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                  children: <Widget> [
                    Row(
                        children: <Widget>[
                          Item(itemId: summonerMatchInfo.build[0], size: 27),
                          Item(itemId: summonerMatchInfo.build[1], size: 27),
                          Item(itemId: summonerMatchInfo.build[2], size: 27)
                        ]
                    ),
                    Row(
                        children: <Widget>[
                          Item(itemId: summonerMatchInfo.build[3], size: 27),
                          Item(itemId: summonerMatchInfo.build[4], size: 27),
                          Item(itemId: summonerMatchInfo.build[5], size: 27)
                        ]
                    )
                  ]
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              children: <Widget>[
                Text(summonerMatchInfo.gamemode!, style: TextStyle(fontSize: 16)),
                Text(summonerMatchInfo.getDateAsString(), style: TextStyle(fontSize: 10))
              ],
            )
          ),
        ],
      )
    );
  }
}