import 'package:flutter/material.dart';

class listview1_screen extends StatelessWidget{
  const listview1_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = const [
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
    ];

    return Scaffold(
      body: ListView(
        children: [
          /*
          Text("Dato #1"),
          Text("Dato #2"),
          Text("Dato #3"),
          ListTile(
            leading: Icon(Icons.lock_clock),
            title: Text("Dato #4"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),*/
          ...options.map(
                (juego) => ListTile(
              leading: Icon(Icons.access_alarm),
              tileColor: Color(0xFFFF9000),
              title: Text(juego),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        ],
      ),
      /*
        body: Center(
          child: Text("listview1Screen"),
        ),*/
    );
  }
}
