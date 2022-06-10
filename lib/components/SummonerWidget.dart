
import 'package:flutter/material.dart';
import 'package:test_project/Summoner.dart';

class SummonerWidget extends StatelessWidget {
  final Summoner summoner;
  Function refreshMatchHistory;

  SummonerWidget({super.key, required this.summoner, required this.refreshMatchHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      height: 130,
      //color: Color(0xffD9D9D9),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              children: [
                Image.network("http://ddragon.leagueoflegends.com/cdn/12.11.1/img/profileicon/${summoner.summonerIconId}.png",
                  width: 85,
                  height: 85,
                ),
                Container(
                  width: 40,
                  height: 18,
                  color: Colors.black,
                  child: Text("${summoner.summonerLevel!}",
                    style: TextStyle(color: Colors.amberAccent, fontSize: 14, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 130,
                child: Center(
                  child: Text(summoner.summonerName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                  )),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: SizedBox(
                    width: 130,
                    child:  TextButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff05aefc)
                      ),
                      onPressed: () => refreshMatchHistory(summoner.getSummonerPuuid()!),
                      child: Text(
                        'Refresh',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: SizedBox(
                    width: 130,
                    child:  TextButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff05aefc)
                      ),
                      onPressed: () {  },
                      child: Text(
                        'Live Game',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      )
    );
  }

}