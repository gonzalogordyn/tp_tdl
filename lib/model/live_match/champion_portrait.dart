import 'package:flutter/material.dart';

class ChampionPortrait extends StatelessWidget{
    final String championName;
    final double imageSize;

    const ChampionPortrait({Key? key, required this.championName, required this.imageSize}): super(key: key);


  @override
  Widget build(BuildContext context) {
      return Image.network(
          'http://ddragon.leagueoflegends.com/cdn/12.11.1/img/champion/$championName.png',
          width: imageSize,
          height: imageSize,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
              return SizedBox(
                  height: imageSize,
                  width: imageSize,
                  child: Container(
                    color: Colors.grey,
                    child: Icon(Icons.error_outline_rounded)
                  )
              );
          }
      );
  }
}