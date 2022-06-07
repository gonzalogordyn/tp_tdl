
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final int itemId;
  final double size;
  const Item({Key? key, required this.itemId, required this.size}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Image.network(
          'http://ddragon.leagueoflegends.com/cdn/12.10.1/img/item/$itemId.png',
          width: size,
          height: size
      )
    );
    
  }

}