import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Drawer(
          child: Material(
              color: Color(0xff192941),
              child: ListView(
                  children: <Widget>[
                      const SizedBox(height: 100),
                      Divider(color: Color(0xff2d4873)),
                      buildMenuItem(
                          text: 'Match history',
                          icon: Icons.menu_book_rounded,
                          onClicked: (){}
                      ),
                      buildMenuItem(
                          text: 'Search summoner',
                          icon: Icons.search_rounded,
                          onClicked: (){}
                      ),
                    buildMenuItem(
                      text: 'Live game',
                      icon: Icons.play_arrow_rounded,
                      onClicked: (){}
                    ),
                    buildMenuItem(
                      text: 'Statistics',
                      icon: Icons.bar_chart,
                      onClicked: (){}
                    ),
                    buildMenuItem(
                      text: 'Latency test',
                      icon: Icons.wifi,
                      onClicked: (){}
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
