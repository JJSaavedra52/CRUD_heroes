import 'package:fl_componentes/models/menu_optons.dart';
import 'package:fl_componentes/screens/screens.dart' ;
import 'package:flutter/material.dart' ;

class AppRoutes {
  static const initialRoute = "home";

  static final menuOptions = <MenuOption> [
    MenuOption(route: "home", icon: Icons.home, name: "Home", screen: HomeScreen()),
    MenuOption(route: "card", icon: Icons.card_giftcard_outlined, name: "Card", screen: CardScreen()),
    MenuOption(route: "alert", icon: Icons.add_alert_outlined, name: "Alert", screen: AlertScreen()),
    MenuOption(route: "listview1", icon: Icons.list_alt_outlined, name: "Listview1", screen: Listview1Screen()),
    MenuOption(route: "listview2", icon: Icons.list_alt_outlined, name: "Listview2", screen: Listview2Screen()),
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final option in menuOptions){
      appRoutes.addAll({ option.route: (BuildContext context) =>  option.screen});
    }

    return appRoutes;

    /*
    'home' : (BuildContext context) =>  const HomeScreen(),
    'card' : (BuildContext context) =>  const CardScreen(),
    'alert' : (BuildContext context) =>  const AlerScreen(),
    'listview1' : (BuildContext context) =>  const Listview1Screen(),
    'listview2' : (BuildContext context) =>  const Listview2Screen(),*/
  }
  /* mejorar el enrutador
  static Map<String, Widget Function(BuildContext)> routes = ...menuOptions.map((option) => {
      {option.route: option.getRoute()}
  });*/

  static Route<dynamic> onGenerateRoute =
      MaterialPageRoute(
          builder: (context) => const AlertScreen()
  );

}