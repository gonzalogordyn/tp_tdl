import 'package:flutter/material.dart';

import '../model/summoner_match_info.dart';
import './item.dart';

class MatchPreview extends StatelessWidget {
  final SummonerMatchInfo summonerMatchInfo;

  MatchPreview({
    Key? key,
    required this.summonerMatchInfo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: summonerMatchInfo.won ? Color(0xff92DEF6) : Color(0xffFB9191),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.network(
                'http://ddragon.leagueoflegends.com/cdn/12.10.1/img/champion/${summonerMatchInfo.championName}.png',
                width: 70,
                height: 70
            )
          ),
          Container(
            constraints: BoxConstraints(minWidth: 90, maxWidth: 90),
            child: Column(
              children: <Widget>[
                Text(summonerMatchInfo.getScoreAsString(), style: Theme.of(context).textTheme.headline4),
                Text("KDA: ${summonerMatchInfo.getKDA()}", style: Theme.of(context).textTheme.headline5),
              ]
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
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
                Text(summonerMatchInfo.gamemode!, style: Theme.of(context).textTheme.headline4),
                Text(summonerMatchInfo.getDateAsString(), style: Theme.of(context).textTheme.headline5)
              ],
            )
          ),
        ],
      )
    );
  }
}