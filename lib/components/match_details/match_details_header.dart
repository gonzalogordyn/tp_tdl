import 'package:flutter/material.dart';

class MatchDetailsHeader extends StatelessWidget {
  const MatchDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        buildButton("Summary"),
        Expanded(child: SizedBox()),
        buildButton("Details"),
        Expanded(child: SizedBox()),
        buildButton("Build"),
        Expanded(child: SizedBox()),
      ]
    );
  }

  Widget buildButton(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: SizedBox(
        width: 110,
        child:  TextButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xff05aefc)
          ),
          onPressed: () => {print("Pressed $text")},
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}