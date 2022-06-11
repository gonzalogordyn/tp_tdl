import 'package:flutter/material.dart';

// Easiest way I found to do this...
AppBar userHeader(int summonerIconId, int summonerLevel) {
  return AppBar(
    elevation: 1.0,
    backgroundColor: Color(0xff263F65),
    centerTitle: true,
    title: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Stack(
          children: [
            CircleAvatar(
                backgroundColor: Color(0xffa98101),
                radius: 20,
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage("http://ddragon.leagueoflegends.com/cdn/12.11.1/img/profileicon/$summonerIconId.png"),
                )
            ),
            Positioned(
              top: 28.0,
              left: 5.0,
              child: Container(
                width: 30,
                height: 15,
                color: Color(0xffa98101),
                child: Text("$summonerLevel",
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )
    ),
  );
}