import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/views/live_game.dart';
import 'package:test_project/views/summoner_login.dart';
import '../model/summoner/summoner.dart';
import '../views/summoner_history.dart';
import 'dart:convert';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late Summoner summoner;

  @override
  void initState(){
      super.initState();
      final prefsFuture = SharedPreferences.getInstance();

      prefsFuture.then((prefs) {
        String? accountsStr = prefs.getString("accounts");
        String? prefServerID = prefs.getString("server");
        if(accountsStr != null) {
          summoner = Summoner.fromJson(jsonDecode(accountsStr), prefServerID!);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
      return Drawer(
          child: Material(
              color: Color(0xff192941),
              child: ListView(
                  children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          child: Row(
                              children: <Widget>[
                                  CircleAvatar(
                                      backgroundColor: Color(0xffa98101),
                                      radius: 30,
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundImage: NetworkImage("http://ddragon.leagueoflegends.com/cdn/12.11.1/img/profileicon/${summoner.summonerIconId}.png"),
                                      )
                                  ),
                                  SizedBox(width:10),
                                  Text(summoner.summonerName!, style: TextStyle(fontSize: 20.0, color: Colors.white))
                              ],
                          ),
                      ),
                      Divider(color: Color(0xff2d4873)),
                      buildMenuItem(
                          text: 'Match history',
                          icon: Icons.menu_book_rounded,
                          onClicked: (){
                              if(summoner != null){
                                Navigator.push(context,
                                    MaterialPageRoute(
                                    builder: (context) => SummonerHistory(summoner: summoner),
                                    ),
                                );
                              }
                          }
                      ),
                      buildMenuItem(
                          text: 'Search summoner',
                          icon: Icons.search_rounded,
                          onClicked: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => SummonerInputScreen(newSearch: true),
                                  ),
                              );
                          }
                      ),
                    buildMenuItem(
                      text: 'Live game',
                      icon: Icons.play_arrow_rounded,
                      onClicked:  (){
                        if(summoner != null){
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => LiveGame(summonerId: summoner.summonerId, serverID: summoner.region),
                            ),
                          );
                        }
                      }
                    ),
                    buildMenuItem(
                        text: 'Log out',
                        icon: Icons.logout,
                        onClicked: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove("accounts");
                            await prefs.remove("server");
                            Navigator.of(context).popUntil(ModalRoute.withName("/summonerinput"));
                        }
                    ),
                  ],
            )
          ),


      );
  }

  Widget buildMenuItem({required String text, required IconData icon, VoidCallback? onClicked}){
      const color = Colors.white;
      const fontSize = 20.0;

      return ListTile(
          leading: Icon(icon, color: color),
          title: Text(text, style: TextStyle(color: color, fontSize: fontSize)),
          onTap: onClicked,
      );
  }
}
