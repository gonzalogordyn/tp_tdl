import 'package:flutter/material.dart';

class SummonerInputScreen extends StatefulWidget{
  @override
  State<SummonerInputScreen> createState() => _SummonerInputScreenState();
}

class _SummonerInputScreenState extends State<SummonerInputScreen> {

  late String summonerName;
  late String serverID;

  @override

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff003d73),
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
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 30.0),
                    child: SizedBox(
                      width: 250.0,
                      child: TextField(
                        onChanged: (text){
                          summonerName = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Enter summoner name',
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 80.0,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: Colors.white,
                      ),
                      child: const Center(child: ServerDropdownMenu()),
                  ),

                ]
            ),
            const SizedBox(
                height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {},
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
  const ServerDropdownMenu({Key? key}) : super(key: key);

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
          });

        },
        items: <String>['LAS', 'NA', 'EUW', 'EUNE', 'LAN', 'BR', 'JP', 'TR']
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