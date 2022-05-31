import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SummonerInputScreen(),
  ));
}

class SummonerInputScreen extends StatelessWidget{
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
                    padding: EdgeInsets.all(30.0),
                    child: SizedBox(
                        width: 250.0,
                        child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter summoner name',
                              ),
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: ServerDropdownMenu(),

                  ),

              ]
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
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
      icon: const Icon(Icons.expand_more_rounded),
      isDense: true,
      elevation: 16,
      menuMaxHeight: 200.0,
      style: const TextStyle(color: Colors.deepPurple),
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