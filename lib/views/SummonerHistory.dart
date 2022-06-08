import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_project/components/MatchPreview.dart';
import '../User.dart';
import '../SummonerMatchInfo.dart';

const String API_KEY = "RGAPI-818c6a07-3e3a-4442-ad80-9057c72fe28b";

class SummonerHistory extends StatefulWidget {
  SummonerHistory({
    Key? key,
  }) : super(key: key);

  @override
  _SummonerHistoryState createState() => _SummonerHistoryState();

}

class _SummonerHistoryState extends State<SummonerHistory> {

  late User user;

  Object? data;

  @override
  void initState() {
    super.initState();

    //TODO: CAMBIAR SummonerMatchInfo a Match asi se puede usar en la vista de Match

  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments;
    user = User('Lockhy', 'LAS');
    print(data);

    return Material(
        color: Color(0xff003d73),
        child: Column(
            children: <Widget>[
              SizedBox(height:60),
              Text("SUMMONER_NAME", style: TextStyle(color: Colors.white),),
              SizedBox(height:50),
              FutureBuilder<List<SummonerMatchInfo>>(
                future: user.matchHistoryInfo,
                builder: (BuildContext context, AsyncSnapshot<List<SummonerMatchInfo>> snapshot) {
                  if(snapshot.hasError) {
                    return Text("${snapshot.error}", style: TextStyle(color: Colors.white));
                  } else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    return Text("We couldn't find any games on your match history", style: TextStyle(color: Colors.white));
                  } else if(snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return MatchPreview(summonerMatchInfo: snapshot.data![index]);
                            //return Text("${snapshot.data![index].championName}", style: TextStyle(color: Colors.white));
                          })
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              ),

              SizedBox(height:20),
            ]
        )
    );
  }
}
