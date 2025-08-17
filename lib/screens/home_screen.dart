import 'package:fl_componentes/models/menu_optons.dart' show MenuOption;
import 'package:fl_componentes/router/app_router.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuOption> menuOptions = AppRoutes.menuOptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Componentes en flutter"),
        elevation: 0,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: Icon(menuOptions[index].icon),
            title: Text(menuOptions[index].name),
            onTap: (){
              //final route = MaterialPageRoute(builder: (context) => Listview1Screen(),);

              //Navigator.push(context, route);

              Navigator.pushNamed(context, menuOptions[index].route);

              //Navigator.pushReplacement(context, route);
            },
          ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: menuOptions.length
      ),
    );
  }
}