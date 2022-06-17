import 'package:flutter/material.dart';

class MatchDetailsHeader extends StatelessWidget {
  const MatchDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: SizedBox(
            width: 110,
            child:  TextButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff05aefc)
              ),
              onPressed: () => {print("Pressed summary")},
              child: Text(
                'Summary',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: SizedBox(
            width: 110,
            child:  TextButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff05aefc)
              ),
              onPressed: () =>  {print("Details")},
              child: Text(
                'Details',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: SizedBox(
            width: 110,
            child:  TextButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff05aefc)
              ),
              onPressed: () =>  {print("Build")},
              child: Text(
                'Build',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
      ]
    );
  }


}