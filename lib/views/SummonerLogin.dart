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
      appBar: AppBar(
        title: const Text('GG.OP',
          style: TextStyle(
            fontSize: 30.0,
            letterSpacing: 2.0,
            fontFamily: 'Roboto-Black',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              height: 300.0,
              child: Image.asset('assets/pengu.png'),
            ),
            Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                      width: 250.0,
                      child: TextField(
                        onChanged: (text){
                          summonerName = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter summoner name',
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      width: 60.0,
                      child: ServerDropdownMenu(),

                    ),
                  ),

                ]
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print(summonerName);
        },
        child: Text('GO'),
        backgroundColor: Colors.blue[500],
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
    return DropdownButton<String>(
      value: dropdownValue,
      focusColor: Colors.amber,
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
    );
  }
}