import 'package:flutter/material.dart';
import '../components/item.dart';


class MatchParticipantRow extends StatelessWidget {
  final String championName;
  final String mainRune;
  final String secondaryRune;
  final String summonerName;
  final String score;
  final String kda;
  final List<int> items;
  final Color color;

  const MatchParticipantRow({Key? key, required this.championName,
    required this.mainRune,
    required this.secondaryRune,
    required this.summonerName,
    required this.score,
    required this.kda,
    required this.items,
    required this.color,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Container (
          color: color,
          child:Row(
            children: <Widget> [
              // Text("teamPosition"),
              Image.network(
                'http://ddragon.leagueoflegends.com/cdn/12.10.1/img/champion/$championName.png',
                width: 40,
                height: 40,
              ),
              // Text("runas"),
              // Text("summoners"),
              SizedBox(width: 5),
              Text(summonerName, style: Theme.of(context).textTheme.headline4),
              Expanded(child: SizedBox()),

              Column (
                children: [
                  Text(score, style: Theme.of(context).textTheme.bodyLarge),
                  Text("KDA: $kda", style: Theme.of(context).textTheme.caption)
                ],
              ),
              SizedBox(width: 5),
              Column (
                  children: [
                    Row(
                        children: <Widget>[
                          Item(itemId: items[0], size: 20),
                          Item(itemId: items[1], size: 20),
                          Item(itemId: items[2], size: 20)
                        ]
                    ),
                    Row(
                        children: <Widget>[
                          Item(itemId: items[3], size: 20),
                          Item(itemId: items[4], size: 20),
                          Item(itemId: items[5], size: 20)
                        ]
                    ),
                  ]
              )
            ],
          ),
        )



    );
  }
}