import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget{
  const Listview2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = const [
      'Megaman',
      'Metal Gear',
      'Super Smash',
      'Final Fantasy',
    ];

    itemBuilder(context, index) => ListTile(
      leading: Icon(Icons.access_time_sharp, color: Colors.red),
      title: Text(options[index]),
      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.indigo,),
      onTap: (){
        final juego = options[index];
        print(juego);
      },
    );

    separateBuilder(context, index) => const Divider(
      color: Colors.red,
      height: 20,
      endIndent: 20,
      indent: 50,
      thickness: 10,
      radius: BorderRadiusGeometry.vertical(bottom: Radius.circular(10)),
    );

    return Scaffold(
        /*
        body: Center(
          child: Text("listview2Screen"),
        ),*/
        body:ListView.separated(
          itemBuilder: itemBuilder,
          separatorBuilder: separateBuilder,
          itemCount: options.length)
    );
  }
}
