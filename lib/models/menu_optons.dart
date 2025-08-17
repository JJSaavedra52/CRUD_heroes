import 'package:flutter/cupertino.dart';

class MenuOption {
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  final IconData? tralling;

  MenuOption({
    required this.route,
    required this.icon,
    required this.name,
    required this.screen,
    this.tralling,
  });

  Widget Function(BuildContext) getRoute(){
    return (BuildContext context) =>  screen;
  }

}