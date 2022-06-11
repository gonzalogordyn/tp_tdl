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

  const MatchParticipantRow({Key? key, required this.championName,
    required this.mainRune,
    required this.secondaryRune,
    required this.summonerName,
    required this.score,
    required this.kda,
    required this.items
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Row(
          children: <Widget> [
            Image.network(
              'http://ddragon.leagueoflegends.com/cdn/12.10.1/img/champion/$championName.png',
              width: 40,
              height: 40,
            ),
            // Text("runas"),
            // Text("summoners"),
            SizedBox(width: 5),
            Text(summonerName),
            Expanded(child: SizedBox()),

            Column (
              children: [
                Text(score),
                Text("$kda KDA")
              ],
            ),
            SizedBox(width: 5),
            Column (
                children: [
                  Row(
                      children: <Widget>[
                        Item(itemId: items[0], size: 15),
                        Item(itemId: items[1], size: 15),
                        Item(itemId: items[2], size: 15)
                      ]
                  ),
                  Row(
                      children: <Widget>[
                        Item(itemId: items[3], size: 15),
                        Item(itemId: items[4], size: 15),
                        Item(itemId: items[5], size: 15)
                      ]
                  ),
                ]
            )
          ],
        )

    );
  }
}