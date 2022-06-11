import 'package:flutter/material.dart';

import '../model/match/match_participant.dart';
import '../model/match/match.dart';
import './item.dart';

class MatchPreview extends StatelessWidget {
  final MatchParticipant matchParticipant;
  final Match match;

  MatchPreview({
    Key? key,
    required this.matchParticipant,
    required this.match
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: matchParticipant.win ? Color(0xff92DEF6) : Color(0xffFB9191),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.network(
                'http://ddragon.leagueoflegends.com/cdn/12.10.1/img/champion/${matchParticipant.championName}.png',
                width: 70,
                height: 70
            )
          ),
          Container(
            constraints: BoxConstraints(minWidth: 90, maxWidth: 90),
            child: Column(
              children: <Widget>[
                Text(matchParticipant.getScoreAsString(), style: Theme.of(context).textTheme.headline4),
                Text("KDA: ${matchParticipant.getKDA()}", style: Theme.of(context).textTheme.headline5),
              ]
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
              child: Column(
                  children: <Widget> [
                    Row(
                        children: <Widget>[
                          Item(itemId: matchParticipant.build[0], size: 27),
                          Item(itemId: matchParticipant.build[1], size: 27),
                          Item(itemId: matchParticipant.build[2], size: 27)
                        ]
                    ),
                    Row(
                        children: <Widget>[
                          Item(itemId: matchParticipant.build[3], size: 27),
                          Item(itemId: matchParticipant.build[4], size: 27),
                          Item(itemId: matchParticipant.build[5], size: 27)
                        ]
                    )
                  ]
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              children: <Widget>[
                Text(match.gameMode, style: Theme.of(context).textTheme.headline4),
                Text(match.getDateAsString(), style: Theme.of(context).textTheme.headline5)
              ],
            )
          ),
        ],
      )
    );
  }
}