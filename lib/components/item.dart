
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final int itemId;
  final double size;
  const Item({Key? key, required this.itemId, required this.size}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: _itemAsset()

    );
    
  }

  Widget _itemAsset() {
    if(itemId == 0) {
      return SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0x775c5c5c)
          ),
        )
      );
    } else {
      return Image.network(
          'http://ddragon.leagueoflegends.com/cdn/12.11.1/img/item/$itemId.png',
          width: size,
          height: size
      );
    }
  }
}