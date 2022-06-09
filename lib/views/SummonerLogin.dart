import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../Summoner.dart';
import '../views/SummonerHistory.dart';
import 'dart:convert';

const String API_KEY = "RGAPI-bcdb9e9a-4f3f-4013-a513-ff9b7908dd8e";

class SummonerInputScreen extends StatefulWidget{
  @override
  State<SummonerInputScreen> createState() => _SummonerInputScreenState();
}

class _SummonerInputScreenState extends State<SummonerInputScreen> {

  late String summonerName;
  String serverID = 'LAS';

  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void refresh(String newServerID){
      setState((){
        serverID = newServerID;
      });
  }

  @override

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff263F65),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100.0,
            ),
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Image.asset('assets/pengu.png'),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 30.0),
                    child: SizedBox(
                      width: 250.0,
                      child: TextField(
                        controller: _text,
                        onChanged: (text){
                          summonerName = text;
                        },
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          hintText: 'Enter summoner name',
                          errorText: _validate ? 'This field can\'t be empty' : null,
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35.0, 0, 10.0),
                    child: Container(
                        width: 80.0,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            color: Colors.white,
                        ),
                        child: Center(
                            child: ServerDropdownMenu(notifyParent: refresh)
                        ),
                    ),
                  ),

                ]
            ),
            const SizedBox(
                height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                setState((){});
                _text.text.isEmpty ? _validate = true : _validate = false;

                Summoner summoner = await fetchSummonerInfo(summonerName);
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => SummonerHistory(summoner: summoner),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.blue[700],
                  elevation: 0,
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Text(
                    'SEARCH',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto-Black.ttf',
                        fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServerDropdownMenu extends StatefulWidget {
  final Function(String serverID) notifyParent;

  const ServerDropdownMenu({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<ServerDropdownMenu> createState() => _ServerDropdownMenu();
}

class _ServerDropdownMenu extends State<ServerDropdownMenu> {
  String dropdownValue = 'LAS';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.expand_more_rounded),
        elevation: 4,
        alignment: AlignmentDirectional.topStart,
        menuMaxHeight: 200.0,
        style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
        ),
        borderRadius: BorderRadius.circular(10.0),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            setState((){widget.notifyParent(dropdownValue);});
          });

        },
        items: <String>['LAS', 'NA', 'EUW', 'EUNE', 'LAN', 'BR', 'JP', 'TR', 'OCE', 'RU']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

Future<Summoner> fetchSummonerInfo(String summonerName) async {

  // TODO: que cambie url segun el server elegido

  String url = "https://la2.api.riotgames.com/lol/summoner/v4/summoners/by-name/${summonerName}";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": API_KEY
  });

  Map<String, dynamic> parsedJson = jsonDecode(res.body);
  if (res.statusCode == 200) {
    return Summoner.fromJson(parsedJson);
  } else {
    throw Exception('An error occurred fetching the summoner data with name $summonerName. Please try again later. ${res.body}');
  }
}